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

/**
 
 A SpritePart is a functional unit of a SpriteObject. These are single sprites that may be part of a complex entity. They contain a set of animations (represented by TimeLine objects) and can run a single animation.
 
 */

extern NSString *const partAnimations;
extern NSString *const partRunningAnimation;

@interface SpritePart : NSObject {
    
    NSString *name;
    
    @private
    NSObject<GraphicsProtocol> *spriteRep;
    
    TimeLine *currentTimeLine;
    NSDictionary *animations;
    
}

@property (nonatomic, retain) NSString *name;

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) partWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

- (void) update:(double) dt;
- (void) runAnimation:(NSString *) animationName;

- (void) setSpriteRep:(NSObject<GraphicsProtocol> *) rep;

@end
