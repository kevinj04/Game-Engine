//
//  SpritePart.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimeLine.h"
#import "GraphicsProtocol.h"
#import "SpriteObject.h"
/**
 
 A SpritePart is a functional unit of a SpriteObject. These are single sprites that may be part of a complex entity. They contain a set of animations (represented by TimeLine objects) and can run a single animation.
 
 */

extern NSString *const partAnimations;
extern NSString *const partRunningAnimation;
extern NSString *const partZIndex;
extern NSString *const partZOrder;

@interface SpritePart : NSObject {
    
    NSString *name;
    
    @private
    NSObject<GraphicsProtocol> *spriteRep;
    
    TimeLine *currentTimeLine;
    NSDictionary *animations;
    
    SpriteObject *parent;

    float zIndex;
    int zOrder;
    
}

@property (nonatomic, retain) NSString *name;

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) partWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

- (void) update:(double) dt;
- (void) runAnimation:(NSString *) animationName;

- (void) setParent:(SpriteObject *) spriteObj;
- (void) setSpriteRep:(NSObject<GraphicsProtocol> *) rep;
- (NSObject<GraphicsProtocol> *) spriteRep;

@end
