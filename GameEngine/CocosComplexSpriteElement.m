//
//  CocosComplexSpriteElement.m
//  TestGame
//
//  Created by Kevin Jenkins on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CocosComplexSpriteElement.h"
#import "CocosSpriteRepresentation.h"
#import "SpritePart.h"

@implementation CocosComplexSpriteElement

- (id) initWithDictionary:(NSDictionary *)dictionary 
   andAnimationDictionary:(NSDictionary *) animationDictionary {
    
    if (( self = [super initWithDictionary:dictionary] )) {
        
        [self setupWithDictionary:dictionary andAnimationDictionary:animationDictionary];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) graphicalGameElementWithDictionary:(NSDictionary *) dictionary 
                   andAnimationDictionary:(NSDictionary *) animationDictionary {
    return [[[CocosComplexSpriteElement alloc] initWithDictionary:dictionary 
                                           andAnimationDictionary:animationDictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *)dictionary 
      andAnimationDictionary:(NSDictionary *) animationDictionary {
    
    [super setupWithDictionary:dictionary];
    
    NSDictionary *animationEntry = [animationDictionary objectForKey:[self objectId]];
    
    graphics = [[SpriteObject objectWithDictionary:animationEntry] retain];
    
    if (animationEntry != nil) {
        
        NSDictionary *partsDictionary = [animationEntry objectForKey:spriteObjectParts];    
        
        for (NSString *partName in [partsDictionary allKeys]) {
            
            NSDictionary *animForPartDictionary = [partsDictionary objectForKey:partName];
            
            CocosSpriteRepresentation *rep = [CocosSpriteRepresentation spriteRepresentationWithDictionary:animForPartDictionary];
            
            [graphics setSpriteRep:rep forPart:partName];
            
            // hook up sprite batch node
            if (batchNode == nil) {
                
                NSString *spriteFrameName = [rep spriteFrameName];
                CCTexture2D *tx = [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:spriteFrameName] texture];
                
                batchNode = [[CCSpriteBatchNode alloc] initWithTexture:tx capacity:[[graphics parts] count]];
                [batchNode setAnchorPoint:ccp(0.5,0.5)];
                [self addChild:batchNode z:0];
                
            }
            
            if (batchNode != nil) {         
                // todo: handle z-indexing
                [batchNode addChild:rep z:0];
                [rep setUsesBatchNode:YES];
                [rep setBatchNode:batchNode];
            }
            
        }
        
    }
    
}
- (void) dealloc {
    
    if (graphics != nil) { [graphics release]; graphics = nil; }
    if (batchNode != nil) {[graphics release]; graphics = nil; }
    
    [super dealloc];
    
}

- (void) update:(double)dt {
    
    rotationTemp++;
    
    //[self setRotation:rotationTemp];
    [batchNode setPosition:[self position]];
    [batchNode setRotation:[self rotation]];
    
    [self setPosition:ccp([self position].x, [self position].y)];
    
    //[graphics setPosition:[self position]];
    //[graphics setRotation:[self rotation]];
    [graphics setScale:[self scale]];
    
    [graphics update:dt];
    
    [super update:dt];
}

- (void) attachToLayer:(CCLayer *) layer {
    [layer addChild:self z:1];
}
- (void) runAnimation:(NSString *) animationName {
    [graphics runAnimation:animationName];
}
- (void) runAnimation:(NSString *) animationName onPart:(NSString *)partName {
    [graphics runAnimation:animationName onPart:partName];
}

- (void) setRotation:(float)rotation {
    // todo: maybe better way to do this?
    [batchNode setRotation:rotation];
}

@end
