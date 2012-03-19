//
//  CocosBackgroundElement.m
//  TestGame
//
//  Created by Kevin Jenkins on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CocosBackgroundElement.h"
#import "SpriteObject.h"
#import "SpritePart.h"

@interface CocosBackgroundElement (hidden)
- (void) updateBackgroundWithInfo:(NSObject<SpriteUpdateProtocol> *) p;
- (void) updateSprite:(NSObject<SpriteUpdateProtocol> *) p;
@end

@implementation CocosBackgroundElement (hidden)
- (void) updateBackgroundWithInfo:(NSObject<SpriteUpdateProtocol> *) p {
    [backgroundSprite setPosition:[p position]];
    [backgroundSprite setRotation:[p rotation]];
    
    [backgroundSprite setScaleX:[p scaleX]];
    [backgroundSprite setScaleY:[p scaleY]];
    
    [backgroundSprite setVertexZ:[p vertexZ]];
    [backgroundSprite setZOrder:[p zOrder]]; // maybe slow?
    [backgroundSprite setVisible:[p visible]];
    
    [backgroundSprite setAnchorPoint:[p anchorPoint]];
}
- (void) updateSprite:(NSObject<SpriteUpdateProtocol> *) p {
    
    CCSprite *s = [backgroundElements objectForKey:[p name]];
    
    if (s == nil) { return; }
    
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[p spriteFrameName]];
    
    if (frame != [s displayedFrame]) {
        [s setDisplayFrame:frame];
        [spriteFrameOffsets setObject:NSStringFromCGPoint([frame offsetInPixels]) forKey:[p name]];
    }
    
    [s setDisplayFrame:frame];
    [s setPosition:[p position]];
    [s setRotation:[p rotation]];
    
    [s setScaleX:[p scaleX]];
    [s setScaleY:[p scaleY]];
    
    [s setVertexZ:[p vertexZ]];
    [s setZOrder:[p zOrder]]; // maybe slow?
    [s setVisible:[p visible]];
    
    [s setAnchorPoint:[p anchorPoint]];
    
}
@end

@implementation CocosBackgroundElement

- (id) initWithSpriteBGObject:(SpriteBGObject *) bgObj {
    
    if (( self = [super init] )) {
        
        [self setupWithSpriteBGObject:bgObj];
        return self;
    } else {
        return nil;
    }
    
}
+ (id) backgroundElementWithSpriteBGObject:(SpriteBGObject *) bgObj {
    return [[[CocosBackgroundElement alloc] initWithSpriteBGObject:bgObj] autorelease];
}
- (void) setupWithSpriteBGObject:(SpriteBGObject *) bgObj {
    
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithCapacity:[[[bgObj parts] allValues] count]];
    NSMutableDictionary *temp2 = [NSMutableDictionary dictionaryWithCapacity:[[[bgObj parts] allValues] count]];
    
    backgroundSprite = [CCSprite spriteWithFile:[bgObj backgroundFileName]];
    [self updateBackgroundWithInfo:bgObj];
    
    for (SpritePart *part in [[bgObj parts] allValues]) {
        
        CCSprite *s = [CCSprite node];        
        [self updateSprite:part];            
        
        [backgroundSprite addChild:s z:[part zOrder]];
        
        [temp setObject:s forKey:[part name]];
        [temp2 setObject:NSStringFromCGPoint([[s displayedFrame] offsetInPixels]) forKey:[part name]];
        [part setSpriteRep:(NSObject<GraphicsProtocol> *)s];
    }
    
    backgroundElements = [temp retain];
    spriteFrameOffsets = [temp2 retain];
    [self addChild:backgroundSprite z:0];
}

- (void) dealloc {
    
    if (backgroundSprite != nil) { [backgroundSprite release]; backgroundSprite = nil; }
    if (backgroundElements != nil) { [backgroundElements release]; backgroundElements = nil; }
    
    [super dealloc];
    
}

- (void) update:(double)dt {
 
}
- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *) updateObj {
    
    SpriteBGObject *bgObj = (SpriteBGObject *)updateObj; // must be true for this to update properly
    
    [self updateBackgroundWithInfo:bgObj];
    
    for (SpritePart *part in [[bgObj parts] allValues]) {
        
        [self updateSprite:part];
    }
    
}

- (void) attachToLayer:(CCLayer *) layer {    
    [layer addChild:self z:0];    
}

- (void) setVisible:(BOOL)v {
    [backgroundSprite setVisible:v];
}

- (NSDictionary *) frameOffsets {
    return spriteFrameOffsets;
}

@end
