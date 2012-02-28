//
//  PhysicsObject.h
//  physics
//
//  Created by Kevin Jenkins on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameElement.h"

extern NSString *const physicsObjectSize;
extern NSString *const physicsObjectPosition;

extern NSString *const physicsPositionChange;
extern NSString *const physicsVelocityChange;
extern NSString *const physicsAccelerationChange;
extern NSString *const physicsForceChange;
extern NSString *const physicsCenterOfMassChange;
extern NSString *const physicsMassChange;

@interface PhysicsObject : GameElement {
    
    CGPoint position;
    CGPoint velocity;
    CGPoint acceleration;
    CGPoint centerOfMass;
    CGPoint anchorPoint;
    
    CGPoint force;
    
    CGRect boundary;
    CGSize size;
    
    float mass;
    float rotation;
        
    
    @private
    
}

- (id) init;
+ (id) object;
- (void) setup;
- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) objectWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;


- (CGPoint) position;
- (CGPoint) velocity;
- (CGPoint) acceleration;
- (CGPoint) centerOfMass;
- (CGPoint) force;
- (float) mass;
- (CGSize) size;
- (CGRect) boundary;
- (float) rotation;

- (void) setPosition:(CGPoint) p;
- (void) setVelocity:(CGPoint) v;
- (void) setAcceleration:(CGPoint) a;
- (void) setCenterOfMass:(CGPoint) com;
- (void) setForce:(CGPoint) f;
- (void) setMass:(float) m;
- (void) setSize:(CGSize) s;
- (void) setRotation:(float) r;
- (void) setBoundary:(CGRect) r;

- (void) applyImpulse:(CGPoint) f;
- (void) update:(double) dt;
- (void) accelerate:(CGPoint) a;

- (NSMutableDictionary *) dictionary;
- (void) resetWithDictionary:(NSDictionary *) dictionary;

@end
