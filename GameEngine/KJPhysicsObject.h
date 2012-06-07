//
//  KJPhysicsObject.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJGameObject.h"
#import <UIKit/UIKit.h>


extern NSString *const kjObjectSize;
extern NSString *const kjObjectPosition;
extern NSString *const kjAnchorPoint;

extern NSString *const kjPositionChange;
extern NSString *const kjVelocityChange;
extern NSString *const kjAccelerationChange;
extern NSString *const kjForceChange;
extern NSString *const kjCenterOfMassChange;
extern NSString *const kjMassChange;
extern NSString *const kjRotationChange;
extern NSString *const kjAnchorPointChange;
extern NSString *const kjBoundingBoxChange;
extern NSString *const kjSizeChange;

@interface KJPhysicsObject : KJGameObject {
    
}

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGPoint velocity;
@property (nonatomic, assign) CGPoint acceleration;
@property (nonatomic, assign) CGPoint centerOfMass;
@property (nonatomic, assign) CGPoint anchorPoint;

@property (nonatomic, assign) CGPoint force;

@property (nonatomic, assign) CGRect boundingBox;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) float mass;
@property (nonatomic, assign) float rotation;

@property (nonatomic, assign) float dampingValue;
@property (nonatomic, assign) float minimumVelocity;

// Physics Applications
- (void) applyImpulse:(CGPoint) p;
- (void) applyAcceleration:(CGPoint) a;

// tick step
- (void) update:(double)dt;

@end
