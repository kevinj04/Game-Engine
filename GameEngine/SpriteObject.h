//
//  SpriteObject.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphicsProtocol.h"

extern NSString *const spriteObjectParts;
extern NSString *const spriteObjectAnimations;
extern NSString *const spriteObjectRunningAnimation; 
extern NSString *const spriteZIndex;
extern NSString *const spriteZOrder;

/**
 
 SpriteObject is the graphic representation of a GameElement. It can be composed of any number of sprite parts. Animations are managed by TimeLines which control a series of KeyFrames. When the SpriteObject is updated with a time step, the parts positions, scales, rotations, and sprite frames are updated accordingly -- eased between the expected KeyFrames. 
 
 */

@interface SpriteObject : NSObject {
    
    CGPoint position;
    float rotation;
    float scale;
    double animationSpeed;
    float zIndex;
    int zOrder;
    CGPoint anchorPoint;
    CGRect boundary;
    
    @private
    NSDictionary *parts;
    
}

@property CGPoint position;
@property float rotation;
@property float scale;
@property double animationSpeed;
@property float zIndex;
@property int zOrder;
@property CGPoint anchorPoint;
@property CGRect boundary;

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) objectWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

- (void) update:(double) dt;

- (void) runAnimation:(NSString *) animationName onPart:(NSString *) partName;
- (void) runAnimation:(NSString *) animationName;

- (void) setSpriteRep:(NSObject<GraphicsProtocol> *) rep forPart:(NSString *) partName;
- (NSDictionary *) parts;

- (CGPoint) childBasePosition;

@end
