//
//  SpriteObject.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const spriteObjectParts;
extern NSString *const spriteObjectAnimations;
extern NSString *const spriteObjectRunningAnimation;

/**
 
 SpriteObject is the graphic representation of a GameElement. It can be composed of any number of sprite parts. Animations are managed by TimeLines which control a series of KeyFrames. When the SpriteObject is updated with a time step, the parts positions, scales, rotations, and sprite frames are updated accordingly -- eased between the expected KeyFrames. 
 
 */

@interface SpriteObject : NSObject {
    
    @private
    NSDictionary *parts;
    NSDictionary *runningAnimations;
    
}

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) objectWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

- (void) update:(double) dt;

- (void) runAnimation:(NSString *) animationName onPart:(NSString *) partName;
- (void) runAnimation:(NSString *) animationName;

@end
