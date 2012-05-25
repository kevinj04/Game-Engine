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
    
    CGPoint position;
    CGPoint velocity;
    CGPoint acceleration;
    CGPoint centerOfMass;
    CGPoint anchorPoint;
    
    CGPoint force;
    
    CGRect boundingBox;
    CGSize size;
    
    float mass;
    float rotation;   
    
    @private 
    float dampingValue;
    float minimumVelocity;
}


// getters / setters
- (CGPoint) position;
- (CGPoint) velocity;
- (CGPoint) acceleration;
- (CGPoint) centerOfMass;
- (CGPoint) force;
- (float) mass;
- (CGSize) size;
- (CGRect) boundingBox;
- (CGPoint) anchorPoint;
- (float) rotation;

- (void) setPosition:(CGPoint) p;
- (void) setVelocity:(CGPoint) v;
- (void) setAcceleration:(CGPoint) a;
- (void) setCenterOfMass:(CGPoint) com;
- (void) setForce:(CGPoint) f;
- (void) setMass:(float) m;
- (void) setSize:(CGSize) s;
- (void) setBoundingBox:(CGRect) r;
- (void) setAnchorPoint:(CGPoint) ap;
- (void) setRotation:(float) r;


// Physics Applications
- (void) applyImpulse:(CGPoint) p;
- (void) applyAcceleration:(CGPoint) a;

// tick step
- (void) update:(double)dt;

@end
