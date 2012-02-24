//
//  PhysicsObject.m
//  physics
//
//  Created by Kevin Jenkins on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PhysicsObject.h"

NSString *const physicsObjectSize = @"size";
NSString *const physicsObjectPosition = @"position";

NSString *const physicsPositionChange = @"physicsPositionChange";
NSString *const physicsVelocityChange = @"physicsVelocityChange";
NSString *const physicsAccelerationChange = @"physicsAccelerationChange";
NSString *const physicsForceChange = @"physicsForceChange";
NSString *const physicsCenterOfMassChange = @"physicsCenterOfMassChange";
NSString *const physicsMassChange = @"physicsMassChange";

@implementation PhysicsObject

- (id) init {
    if (( self = [super init] )) {
        
        [self setup];
        
        return self;
    } else {
        return nil;
    }
}
- (id) initWithDictionary:(NSDictionary *) dictionary {
    if (( self = [super init] )) {
        
        [self setupWithDictionary:dictionary];
        return self;
        
    } else {
        return nil;
    }
}
+ (id) objectWithDictionary:(NSDictionary *) dictionary {
    return [[[PhysicsObject alloc] initWithDictionary:dictionary] autorelease];
}
+ (id) object {
    return [[[PhysicsObject alloc] init] autorelease];
}
- (void) setup {
    
    [super setup];
    
    position = CGPointMake(0.0f, 0.0f);
    velocity = CGPointMake(0.0f, 0.0f);
    acceleration = CGPointMake(0.0f, 0.0f);
    centerOfMass = CGPointMake(0.0f, 0.0f);
    
    size = CGSizeMake(5.0, 5.0);
    boundary = CGRectMake(position.x-((size.width-1.0)/2.0), position.y-((size.height-1.0)/2.0), size.width, size.height);
    anchorPoint = CGPointMake(0.5, 0.5); //todo: good default?
    
    mass = 1.0f;

}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    [self setup];
    
    [super setupWithDictionary:dictionary];
    
    if ([dictionary objectForKey:physicsObjectSize] != nil) {
        [self setSize:CGSizeFromString([dictionary objectForKey:physicsObjectSize])];
    }
    
    if ([dictionary objectForKey:physicsObjectPosition] != nil) {
        position = CGPointFromString([dictionary objectForKey:physicsObjectPosition]);
    }
    
}
- (void) dealloc {    
    [super dealloc];
}

- (void) setPosition:(CGPoint) p {
    position = p;
    [[NSNotificationCenter defaultCenter] postNotificationName:physicsPositionChange object:self];
}
- (void) setVelocity:(CGPoint) v {
    velocity = v;
    [[NSNotificationCenter defaultCenter] postNotificationName:physicsVelocityChange object:self];
}
- (void) setAcceleration:(CGPoint) a {
    acceleration = a;
    [[NSNotificationCenter defaultCenter] postNotificationName:physicsAccelerationChange object:self];
}
- (void) setForce:(CGPoint) f {
    force = f;
    [[NSNotificationCenter defaultCenter] postNotificationName:physicsForceChange object:self];
}
- (void) setCenterOfMass:(CGPoint) com {
    centerOfMass = com;
    [[NSNotificationCenter defaultCenter] postNotificationName:physicsCenterOfMassChange object:self];
}
- (void) setMass:(float) m {
    mass = m;
    [[NSNotificationCenter defaultCenter] postNotificationName:physicsMassChange object:self];
}
- (void) setSize:(CGSize) s {
    size = s;
    [self setBoundary:CGRectMake(position.x-((size.width-1.0)/2.0), position.y-((size.height-1.0)/2.0), size.width, size.height)];
}
- (void) setBoundary:(CGRect) r {    
    boundary = r;
    size = CGSizeMake(r.size.width, r.size.height);
    
    CGPoint newOrigin = [self position];
    double xOffset = (self.anchorPoint.x - 0.5f) * self.boundingBox.size.width;
    double yOffset = (self.anchorPoint.y - 0.5f) * self.boundingBox.size.height;
    CGPoint offset = ccp(xOffset, yOffset);
    
    boundary.origin = ccpAdd(newOrigin, offset);
    
}
- (void) setAnchorPoint:(CGPoint) ap {
    anchorPoint = ap;
    [self setBoundary:[self boundary]];
}


- (CGPoint) position { return position; }
- (CGPoint) velocity { return velocity; }
- (CGPoint) acceleration { return acceleration; }
- (CGPoint) force { return force; }
- (CGPoint) centerOfMass { return centerOfMass; }
- (float) mass { return mass; }
- (CGSize) size { return size; }
- (CGRect) boundary { 
    boundary.origin.x = position.x-((size.width-1.0)/2.0); 
    boundary.origin.y = position.y-((size.height-1.0)/2.0); 
    return boundary; 
}
- (CGPoint) anchorPoint {
    return anchorPoint;
}

- (void) applyImpulse:(CGPoint) f {
    CGPoint newV = ccpAdd(f, velocity);
    [self setVelocity:newV];
    
    //[self setForce:ccpAdd(force, f)];
}
- (void) accelerate:(CGPoint) a {
    [self setAcceleration:ccpAdd(acceleration, a)];
}

- (void) update:(double) dt {
    
    if ([self isActive]) {
        
        [self setPosition:ccpAdd(position, ccpMult(velocity, dt))];
        [self setVelocity:ccpAdd(velocity, ccpMult(acceleration,dt))];        
        
        // some sense of friction/damping
        if (ccpFuzzyEqual(velocity, ccp(0,0), 0.01)) { 
            [self setVelocity:ccp(0.0,0.0)]; 
        } else {
            [self setVelocity:ccpMult(velocity, .95)];
        }
        
        [self setAcceleration:ccp(force.x/mass, force.y/mass)];
        
    }
}

- (NSMutableDictionary *) dictionary {
    NSMutableDictionary *d = [super dictionary];
    [d setObject:NSStringFromCGSize(size) forKey:physicsObjectSize];
    [d setObject:NSStringFromCGPoint(position) forKey:physicsObjectPosition];
    
    return d;
}
- (void) resetWithDictionary:(NSDictionary *)dictionary {
    
    [super resetWithDictionary:dictionary];
    
    [self setSize:CGSizeFromString([dictionary objectForKey:physicsObjectSize])];
    [self setPosition:CGPointFromString([dictionary objectForKey:physicsObjectPosition])];    
    
}

@end
