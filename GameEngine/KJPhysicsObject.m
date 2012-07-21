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

@synthesize position = _position;
@synthesize velocity = _velocity;
@synthesize acceleration = _acceleration;
@synthesize centerOfMass = _centerOfMass;
@synthesize anchorPoint = _anchorPoint;
@synthesize force = _force;
@synthesize boundingBox = _boundingBox;
@synthesize size = _size;
@synthesize mass = _mass;
@synthesize rotation = _rotation;
@synthesize dampingValue = _dampingValue;
@synthesize minimumVelocity = _minimumVelocity;

#pragma mark - Initialization
- (id) init
{

    self = [super init];
    if (self)
    {
        // do nothing for now...
    }
    return self;
}
- (id) initWithDictionary:(NSDictionary *) dictionary
{

    self = [super initWithDictionary:dictionary];
    if (self)
    {
        // do nothing for now...
    }

    return self;
}
+ (id) objectWithDictionary:(NSDictionary *) dictionary
{
    return [[[KJPhysicsObject alloc] initWithDictionary:dictionary] autorelease];
}
+ (id) object
{
    return [[[KJPhysicsObject alloc] init] autorelease];
}
- (void) setup
{

    [super setup];

    self.position = CGPointMake(0.0f, 0.0f);
    self.velocity = CGPointMake(0.0f, 0.0f);
    self.acceleration = CGPointMake(0.0f, 0.0f);
    self.centerOfMass = CGPointMake(0.5f, 0.5f);
    self.size = CGSizeMake(5.0, 5.0); // scaling will be handled when setting the bounding box
    self.boundingBox = [Universalizer scaleRectForIPad:CGRectMake(self.position.x-((self.size.width-1.0)/2.0), self.position.y-((self.size.height-1.0)/2.0), self.size.width, self.size.height)];
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.mass = 1.0f;
    self.minimumVelocity = 0.1;
    self.dampingValue = 0.95;

}
- (void) setupWithDictionary:(NSDictionary *) dictionary
{
    [self setup];

    [super setupWithDictionary:dictionary];

    if ([dictionary objectForKey:kjObjectSize] != nil) {
        self.size = [Universalizer scaleSizeForIPad:CGSizeFromString([dictionary objectForKey:kjObjectSize])];
    }

    if ([dictionary objectForKey:kjObjectPosition] != nil) {
        self.position = [Universalizer scalePointForIPad:CGPointFromString([dictionary objectForKey:kjObjectPosition])];
    }

    if ([dictionary objectForKey:kjObjectAnchorPoint] != nil) {
        self.anchorPoint = CGPointFromString([dictionary objectForKey:kjObjectAnchorPoint]);
    }

}
- (void) registerNotifications
{
    [super registerNotifications];
}

#pragma mark - Getters and Setters
- (void) setPosition:(CGPoint) p
{
    _position = p;
    self.boundingBox = [self boundingBox];
    [[NSNotificationCenter defaultCenter] postNotificationName:kjPositionChange object:self];
}
- (void) setVelocity:(CGPoint) v
{
    _velocity = v;
    [[NSNotificationCenter defaultCenter] postNotificationName:kjVelocityChange object:self];
}
- (void) setAcceleration:(CGPoint) a
{
    _acceleration = a;
    [[NSNotificationCenter defaultCenter] postNotificationName:kjAccelerationChange object:self];
}
- (void) setForce:(CGPoint) f
{
    _force = f;
    [[NSNotificationCenter defaultCenter] postNotificationName:kjForceChange object:self];
}
- (void) setCenterOfMass:(CGPoint) com
{
    _centerOfMass = com;
    [[NSNotificationCenter defaultCenter] postNotificationName:kjCenterOfMassChange object:self];
}
- (void) setMass:(float) m
{
    _mass = m;
    [[NSNotificationCenter defaultCenter] postNotificationName:kjMassChange object:self];
}
- (void) setSize:(CGSize) s
{
    _size = s;
    self.boundingBox = CGRectMake(self.position.x-((self.size.width-1.0)/2.0), self.position.y-((self.size.height-1.0)/2.0), self.size.width, self.size.height);
    [[NSNotificationCenter defaultCenter] postNotificationName:kjSizeChange object:self];
}
- (void) setBoundingBox:(CGRect) r
{
    _boundingBox = r;
    if (!CGSizeEqualToSize(r.size, self.size)) {
        self.size = CGSizeMake(r.size.width, r.size.height);
        [[NSNotificationCenter defaultCenter] postNotificationName:kjSizeChange object:self];
    }

    CGPoint newOrigin = self.position;
    double xOffset = self.anchorPoint.x * self.boundingBox.size.width;
    double yOffset = self.anchorPoint.y * self.boundingBox.size.height;

    _boundingBox.origin = CGPointMake(newOrigin.x - xOffset, newOrigin.y - yOffset);

    [[NSNotificationCenter defaultCenter] postNotificationName:kjBoundingBoxChange object:self];

}
- (void) setRotation:(float) r
{
    _rotation = r;
    [[NSNotificationCenter defaultCenter] postNotificationName:kjRotationChange object:self];
}
- (void) setAnchorPoint:(CGPoint) ap
{
    _anchorPoint = ap;
    [self setBoundingBox:[self boundingBox]];
    [[NSNotificationCenter defaultCenter] postNotificationName:kjAnchorPointChange object:self];
}

#pragma mark - Physics Methods
- (void) applyImpulse:(CGPoint) impulse
{
    CGPoint newVelocity = CGPointMake(impulse.x + self.velocity.x, impulse.y + self.velocity.y);
    self.velocity = newVelocity;
}
- (void) applyAcceleration:(CGPoint) a
{
    self.acceleration = CGPointMake(self.acceleration.x + a.x, self.acceleration.y + a.y);
}
// TODO: more methods needed here! applyForce? angularAccel?

#pragma mark - Tick Method
// Someone should probably point me at a serious book on this method...
- (void) update:(double)dt
{

    if (self.isActive|| self.isAlwaysActive)
    {

        self.position = CGPointMake(self.position.x + self.velocity.x * dt, self.position.y + self.velocity.y * dt);
        self.velocity = CGPointMake(self.velocity.x + self.acceleration.x * dt, self.velocity.y + self.acceleration.y * dt);

        // some sense of friction/damping
        if (kjFuzzyEqual(self.velocity, CGPointZero, self.minimumVelocity)) {
            self.velocity = CGPointZero;
        } else {
            self.velocity = CGPointMake(self.velocity.x * powf(self.dampingValue, (dt / (1.0f / 60.0f) )),
                                        self.velocity.y * powf(self.dampingValue, (dt / (1.0f / 60.0f) )));
        }

        self.acceleration = CGPointMake(self.force.x / self.mass, self.force.y / self.mass);

    }

    [super update:dt];
}

@end
