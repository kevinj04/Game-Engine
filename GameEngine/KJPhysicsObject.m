//
//  KJPhysicsObject.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJPhysicsObject.h"
#import "Universalizer.h"

NSString *const kjObjectSize = @"size";
NSString *const kjObjectPosition = @"position";
NSString *const kjObjectAnchorPoint = @"anchorPoint";

NSString *const kjPositionChange = @"physicsPositionChange";
NSString *const kjVelocityChange = @"physicsVelocityChange";
NSString *const kjAccelerationChange = @"physicsAccelerationChange";
NSString *const kjForceChange = @"physicsForceChange";
NSString *const kjCenterOfMassChange = @"physicsCenterOfMassChange";
NSString *const kjMassChange = @"physicsMassChange";
NSString *const kjRotationChange = @"physicsRotationChange";
NSString *const kjAnchorPointChange = @"physicsAnchorPointChange";
NSString *const kjBoundingBoxChange = @"boundingBoxChange";
NSString *const kjSizeChange = @"sizeChange";


// Thank you cocos2d!
@interface KJPhysicsObject (hidden)
BOOL kjFuzzyEqual(CGPoint a, CGPoint b, float var);
@end

@implementation KJPhysicsObject (hidden)
BOOL kjFuzzyEqual(CGPoint a, CGPoint b, float var)
{
	if(a.x - var <= b.x && b.x <= a.x + var)
		if(a.y - var <= b.y && b.y <= a.y + var)
			return true;
	return false;
}
@end


@implementation KJPhysicsObject

#pragma mark -
#pragma mark Initialization
- (id) init {
    if (( self = [super init] )) {
        
        return self;
    } else {
        return nil;
    }
}
- (id) initWithDictionary:(NSDictionary *) dictionary {
    if (( self = [super initWithDictionary:dictionary] )) {
        
        return self;
        
    } else {
        return nil;
    }
}
+ (id) objectWithDictionary:(NSDictionary *) dictionary {
    return [[[KJPhysicsObject alloc] initWithDictionary:dictionary] autorelease];
}
+ (id) object {
    return [[[KJPhysicsObject alloc] init] autorelease];
}
- (void) setup {
    
    [super setup];
    
    position = CGPointMake(0.0f, 0.0f);
    velocity = CGPointMake(0.0f, 0.0f);
    acceleration = CGPointMake(0.0f, 0.0f);
    centerOfMass = CGPointMake(0.0f, 0.0f);
    
    size = [Universalizer scaleSizeForIPad:CGSizeMake(5.0, 5.0)];
    boundingBox = [Universalizer scaleRectForIPad:CGRectMake(position.x-((size.width-1.0)/2.0), position.y-((size.height-1.0)/2.0), size.width, size.height)];
    anchorPoint = CGPointMake(0.5, 0.5); //todo: good default?
    
    mass = 1.0f;
    
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    [super setupWithDictionary:dictionary];
    
    minimumVelocity = 0.1;
    dampingValue = 0.95;
    
    if ([[self objectId] isEqualToString:@"blusky"]) {
        NSLog(@"STOP!");
    }
    
    if ([dictionary objectForKey:kjObjectSize] != nil) {
        [self setSize:[Universalizer scaleSizeForIPad:CGSizeFromString([dictionary objectForKey:kjObjectSize])]];
    }
    
    if ([dictionary objectForKey:kjObjectPosition] != nil) {
        position = [Universalizer scalePointForIPad:CGPointFromString([dictionary objectForKey:kjObjectPosition])];
    }
    
    if ([dictionary objectForKey:kjObjectAnchorPoint] != nil) {
        anchorPoint = CGPointFromString([dictionary objectForKey:kjObjectAnchorPoint]);
    }
    
}
- (void) registerNotifications {
    [super registerNotifications];
}
- (void) dealloc {    
    [super dealloc];
}
#pragma mark -

// getters / setters
- (void) setPosition:(CGPoint) p {
    
    position = p;
    [self setBoundingBox:[self boundingBox]];
    [[NSNotificationCenter defaultCenter] postNotificationName:kjPositionChange object:self];
}
- (void) setVelocity:(CGPoint) v {
    velocity = v;
    [[NSNotificationCenter defaultCenter] postNotificationName:kjVelocityChange object:self];
}
- (void) setAcceleration:(CGPoint) a {
    acceleration = a;
    [[NSNotificationCenter defaultCenter] postNotificationName:kjAccelerationChange object:self];
}
- (void) setForce:(CGPoint) f {
    force = f;
    [[NSNotificationCenter defaultCenter] postNotificationName:kjForceChange object:self];
}
- (void) setCenterOfMass:(CGPoint) com {
    centerOfMass = com;
    [[NSNotificationCenter defaultCenter] postNotificationName:kjCenterOfMassChange object:self];
}
- (void) setMass:(float) m {
    mass = m;
    [[NSNotificationCenter defaultCenter] postNotificationName:kjMassChange object:self];
}
- (void) setSize:(CGSize) s {
    size = s;
    [self setBoundingBox:CGRectMake(position.x-((size.width-1.0)/2.0), position.y-((size.height-1.0)/2.0), size.width, size.height)];
    [[NSNotificationCenter defaultCenter] postNotificationName:kjSizeChange object:self];
}
- (void) setBoundingBox:(CGRect) r {
    
    boundingBox = r;
    if (!CGSizeEqualToSize(r.size, [self size])) {
        size = CGSizeMake(r.size.width, r.size.height);
        [[NSNotificationCenter defaultCenter] postNotificationName:kjSizeChange object:self];
    }
    
    CGPoint newOrigin = [self position];
    double xOffset = (self.anchorPoint.x) * self.boundingBox.size.width;
    double yOffset = (self.anchorPoint.y) * self.boundingBox.size.height;
    
    boundingBox.origin = CGPointMake(newOrigin.x - xOffset, newOrigin.y - yOffset);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kjBoundingBoxChange object:self];
    
}
- (void) setRotation:(float) r {
    rotation = r;
    [[NSNotificationCenter defaultCenter] postNotificationName:kjRotationChange object:self];
}
- (void) setAnchorPoint:(CGPoint) ap {
    anchorPoint = ap;
    [self setBoundingBox:[self boundingBox]];
    [[NSNotificationCenter defaultCenter] postNotificationName:kjAnchorPointChange object:self];
}

- (CGPoint) position { return position; }
- (CGPoint) velocity { return velocity; }
- (CGPoint) acceleration { return acceleration; }
- (CGPoint) force { return force; }
- (CGPoint) centerOfMass { return centerOfMass; }
- (float) mass { return mass; }
- (CGSize) size { return size; }
- (CGRect) boundingBox { return boundingBox; }
- (float) rotation { return rotation; }
- (CGPoint) anchorPoint { return anchorPoint; }

#pragma mark -


#pragma mark Physics Methods
- (void) applyImpulse:(CGPoint) impulse {
    CGPoint newVelocity = CGPointMake(impulse.x + velocity.x, impulse.y + velocity.y);
    [self setVelocity:newVelocity];
}
- (void) applyAcceleration:(CGPoint) a {
    [self setAcceleration:CGPointMake(acceleration.x + a.x, acceleration.y + a.y)];
}
// more methods needed here! applyForce? angularAccel?
#pragma mark -

#pragma mark Tick Method
// Someone should probably point me at a serious book on this method...
- (void) update:(double)dt {

    if ([self isActive]) {
        
        [self setPosition:CGPointMake(position.x + velocity.x * dt, position.y + velocity.y * dt)];
        [self setVelocity:CGPointMake(velocity.x + acceleration.x * dt, velocity.y + acceleration.y * dt)];        
        
        // some sense of friction/damping
        CGPoint zero = CGPointMake(0.0, 0.0);
        if (kjFuzzyEqual(velocity, zero, minimumVelocity)) { 
            [self setVelocity:zero]; 
        } else {
            [self setVelocity:CGPointMake(velocity.x * dampingValue, velocity.y * dampingValue)];
        }
        
        [self setAcceleration:CGPointMake(force.x / mass, force.y / mass)];
        
    }
    
    [super update:dt];
}
#pragma mark -

@end
