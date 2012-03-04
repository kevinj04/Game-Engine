//
//  CocosComplexSpriteElement.m
//  TestGame
//
//  Created by Kevin Jenkins on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CocosComplexSpriteElement.h"
#import "SpritePart.h"
#import "SpriteUpdateProtocol.h"

NSString *const zOrderStr = @"zIndex";

@interface CocosComplexSpriteElement (hidden)
- (void) updateBatchNodeWithInfo:(NSObject<SpriteUpdateProtocol> *) p;
- (void) updateSprite:(CCSprite *) s withInfo:(NSObject<SpriteUpdateProtocol> *) p;
@end

@implementation CocosComplexSpriteElement (hidden)
- (void) updateBatchNodeWithInfo:(NSObject<SpriteUpdateProtocol> *) p {
    [batchNode setPosition:[p position]];
    [batchNode setRotation:[p rotation]];
    
    [batchNode setScaleX:[p scaleX]];
    [batchNode setScaleY:[p scaleY]];
    
    [batchNode setVertexZ:[p vertexZ]];
    [batchNode setZOrder:[p zOrder]]; // maybe slow?
    [batchNode setVisible:[p visible]];
    
    [batchNode setAnchorPoint:[p anchorPoint]];
}
- (void) updateSprite:(CCSprite *) s withInfo:(NSObject<SpriteUpdateProtocol> *) p {
    
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[p spriteFrameName]];
    
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

@implementation CocosComplexSpriteElement

- (id) initWithSpriteInfo:(SpriteObject *) sObj {
    
    if (( self = [super init] )) {        
        [self setupWithSpriteInfo:sObj];
        return self;
    } else {
        return nil;
    }
}
+ (id) spriteElementWithSpriteInfo:(SpriteObject *) sObj {
    return [[[CocosComplexSpriteElement alloc] initWithSpriteInfo:sObj] autorelease];
}
- (void) setupWithSpriteInfo:(SpriteObject *) sObj {

    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithCapacity:[[[sObj parts] allValues] count]];
    
    for (SpritePart *part in [[sObj parts] allValues]) {
                            
        CCSprite *s = [CCSprite node];
        
        [self updateSprite:s withInfo:part];            
        
        if (batchNode == nil) {
            
            CCTexture2D *tx = [[s displayedFrame] texture] ;            
            batchNode = [[CCSpriteBatchNode alloc] initWithTexture:tx capacity:[[[sObj parts] allValues] count]];            
        }
        
        int zOrder;
        if (batchNode != nil) {         
            // todo: handle z-indexing
            zOrder = (int)([part vertexZ] * 100);
            [batchNode addChild:s z:zOrder];
            [s setUsesBatchNode:YES];
            [s setBatchNode:batchNode];
            [s setVertexZ:[sObj vertexZ] + [part vertexZ]];
        }
        
        [temp setObject:s forKey:[part name]];
        
    }
    
    sprites = [temp retain];

}
- (void) dealloc {
    if (batchNode != nil) { [batchNode release]; batchNode = nil; }
    [super dealloc];
}

- (void) update:(double)dt {
    // this is really not necessary?
}
- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *)updateObj {
    
    SpriteObject *sObj = (SpriteObject *)updateObj; // must be true for this to run properly
    
    [self updateBatchNodeWithInfo:sObj];
    
    for (SpritePart *part in [[sObj parts] allValues]) {
        
        CCSprite *s = [sprites objectForKey:[part name]];
        [self updateSprite:s withInfo:part];
        
    }
    
    [self addChild:batchNode z:0];
    
}
- (void) setVisible:(BOOL)v {
    [batchNode setVisible:v];
}

- (void) attachToLayer:(CCLayer *) layer {
    [layer addChild:self z:[batchNode zOrder]];
}
@end
