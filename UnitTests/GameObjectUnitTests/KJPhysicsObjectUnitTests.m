//
//  KJPhysicsObjectUnitTests.m
//  GameEngine
//
//  Created by Kevin Jenkins on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJPhysicsObjectUnitTests.h"
#import "KJPhysicsObject.h"
#import "ObjectCreationHelpers.h"
#import "Universalizer.h"

@interface KJPhysicsObjectUnitTests ()

- (void) handlePositionChangeNotification:(NSNotification *) notification;
- (void) handleVelocityChangeNotification:(NSNotification *) notification;
- (void) handleAccelerationChangeNotification:(NSNotification *) notification;
- (void) handleForceChangeNotification:(NSNotification *) notification;
- (void) handleCenterOfMassChangeNotification:(NSNotification *) notification;
- (void) handleMassChangeNotification:(NSNotification *) notification;
- (void) handleSizeChangeNotification:(NSNotification *) notification;
- (void) handleBoundingBoxChangeNotification:(NSNotification *) notification;
- (void) handleRotationChangeNotification:(NSNotification *) notification;
- (void) handleAnchorPointChangeNotification:(NSNotification *) notification;

@property (nonatomic, assign) bool objectSentPositionChangeNotification;
@property (nonatomic, assign) bool objectSentVelocityChangeNotification;
@property (nonatomic, assign) bool objectSentAccelerationChangeNotification;
@property (nonatomic, assign) bool objectSentForceChangeNotification;
@property (nonatomic, assign) bool objectSentCenterOfMassChangeNotification;
@property (nonatomic, assign) bool objectSentMassChangeNotification;
@property (nonatomic, assign) bool objectSentSizeChangeNotification;
@property (nonatomic, assign) bool objectSentBoundingBoxChangeNotification;
@property (nonatomic, assign) bool objectSentRotationChangeNotification;
@property (nonatomic, assign) bool objectSentAnchorPointChangeNotification;

@end

@implementation KJPhysicsObjectUnitTests

@synthesize objectSentPositionChangeNotification = _objectSentPositionChangeNotification;
@synthesize objectSentVelocityChangeNotification = _objectSentVelocityChangeNotification;
@synthesize objectSentAccelerationChangeNotification = _objectSentAccelerationChangeNotification;
@synthesize objectSentForceChangeNotification = _objectSentForceChangeNotification;
@synthesize objectSentCenterOfMassChangeNotification = _objectSentCenterOfMassChangeNotification;
@synthesize objectSentMassChangeNotification = _objectSentMassChangeNotification;
@synthesize objectSentSizeChangeNotification = _objectSentSizeChangeNotification;
@synthesize objectSentBoundingBoxChangeNotification = _objectSentBoundingBoxChangeNotification;
@synthesize objectSentRotationChangeNotification = _objectSentRotationChangeNotification;
@synthesize objectSentAnchorPointChangeNotification = _objectSentAnchorPointChangeNotification;

#pragma mark - Event Handlers
- (void) handlePositionChangeNotification:(NSNotification *) notification
{
    self.objectSentPositionChangeNotification = YES;
}
- (void) handleVelocityChangeNotification:(NSNotification *) notification
{
    self.objectSentVelocityChangeNotification = YES;
}
- (void) handleAccelerationChangeNotification:(NSNotification *) notification
{
    self.objectSentAccelerationChangeNotification = YES;
}
- (void) handleForceChangeNotification:(NSNotification *) notification
{
    self.objectSentForceChangeNotification = YES;
}
- (void) handleCenterOfMassChangeNotification:(NSNotification *) notification
{
    self.objectSentCenterOfMassChangeNotification = YES;
}
- (void) handleMassChangeNotification:(NSNotification *) notification
{
    self.objectSentMassChangeNotification = YES;
}
- (void) handleSizeChangeNotification:(NSNotification *) notification
{
    self.objectSentSizeChangeNotification = YES;
}
- (void) handleBoundingBoxChangeNotification:(NSNotification *) notification
{
    self.objectSentBoundingBoxChangeNotification = YES;
}
- (void) handleRotationChangeNotification:(NSNotification *) notification
{
    self.objectSentRotationChangeNotification = YES;
}
- (void) handleAnchorPointChangeNotification:(NSNotification *) notification
{
    self.objectSentAnchorPointChangeNotification = YES;
}

#pragma mark - Notification Helpers
- (void) registerForPositionChangeNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePositionChangeNotification:) name:kjPositionChange object:nil];
}
- (void) registerForVelocityChangeNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleVelocityChangeNotification:) name:kjVelocityChange object:nil];
}
- (void) registerForAccelerationChangeNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAccelerationChangeNotification:) name:kjAccelerationChange object:nil];
}
- (void) registerForForceChangeNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleForceChangeNotification:) name:kjForceChange object:nil];
}
- (void) registerForCenterOfMassChangeNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCenterOfMassChangeNotification:) name:kjCenterOfMassChange object:nil];
}
- (void) registerForMassChangeNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMassChangeNotification:) name:kjMassChange object:nil];
}
- (void) registerForSizeChangeNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSizeChangeNotification:) name:kjSizeChange object:nil];
}
- (void) registerForBoundingBoxChangeNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleBoundingBoxChangeNotification:) name:kjBoundingBoxChange object:nil];
}
- (void) registerForRotationChangeNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRotationChangeNotification:) name:kjRotationChange object:nil];
}
- (void) registerForAnchorPointChangeNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAnchorPointChangeNotification:) name:kjAnchorPointChange object:nil];
}

#pragma mark - Test Life Cycle
- (void) setUp
{
    [super setUp];
    self.objectSentPositionChangeNotification = NO;
    self.objectSentVelocityChangeNotification = NO;
    self.objectSentAccelerationChangeNotification = NO;
    self.objectSentForceChangeNotification = NO;
    self.objectSentCenterOfMassChangeNotification = NO;
    self.objectSentMassChangeNotification = NO;
    self.objectSentSizeChangeNotification = NO;
    self.objectSentBoundingBoxChangeNotification = NO;
    self.objectSentRotationChangeNotification = NO;
    self.objectSentAnchorPointChangeNotification = NO;
}

- (void)tearDown
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super tearDown];
}


#pragma mark - Creation Tests
- (void) testShouldCreateDefaultObjectWithEmptyDictionary
{
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];

    STAssertTrue(CGPointEqualToPoint(newObject.position, CGPointZero), @"Default objects should be placed at CGPointZero");
    STAssertTrue(CGPointEqualToPoint(newObject.velocity, CGPointZero), @"Default objects should have zero velocity.");
    STAssertTrue(CGPointEqualToPoint(newObject.acceleration, CGPointZero), @"Default objects should have zero acceleration.");
    STAssertTrue(CGPointEqualToPoint(newObject.force, CGPointZero), @"Default objects should have no applied force vector when created.");
    STAssertTrue(CGPointEqualToPoint(newObject.centerOfMass, CGPointMake(0.5, 0.5)), @"Default objects should have centered center of mass.");
    STAssertTrue(CGSizeEqualToSize(newObject.size, [Universalizer scaleSizeForIPad:CGSizeMake(5.0, 5.0)]), @"Default object should have size 5.0x5.0 -- scaled appropriately.");
    STAssertTrue(CGRectEqualToRect(newObject.boundingBox, [Universalizer scaleRectForIPad:CGRectMake(-2.5,-2.5,5.0,5.0)]), @"Default objects should have bounding box [-2.5 -2.5 5.0 5.0] -- scaled appropriately.");
    STAssertTrue(CGPointEqualToPoint(newObject.anchorPoint, CGPointMake(0.5, 0.5)), @"Default objects should have centered anchor point.");
    STAssertTrue(1.0f == newObject.mass, @"Default objects should have 1.0f mass.");

    STAssertTrue(0.1f == newObject.minimumVelocity, @"New objects should have minimum velocity of 0.1.");
    STAssertTrue(0.95f == newObject.dampingValue, @"New objects should have a damping value of 0.95.");

}

- (void) testShouldCreateObjectWithValuesFromDictionary
{
    KJPhysicsObject *newObject = [ObjectCreationHelpers createPhysicsObjectWithDictionary];

    STAssertTrue(CGSizeEqualToSize([Universalizer scaleSizeForIPad:CGSizeMake(20.0,20.0)], newObject.size), @"Objects created with a dictionary that contains a size value should use that value.");
    STAssertTrue(CGPointEqualToPoint([Universalizer scalePointForIPad:CGPointMake(14.0,19.0)], newObject.position), @"Objects created with a dictionary that contains a position entry should use that value.");
    STAssertTrue(CGPointEqualToPoint(CGPointMake(0.5,0.0), newObject.anchorPoint), @"Objects created with a dictionary that contains an anchorPoint entry should use that value.");
}

#pragma mark - Setter Tests
- (void) testShouldAdjustBoundingBoxWhenSettingPosition
{
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];
    newObject.position = CGPointMake(2.5, 2.5);

    STAssertTrue(CGRectEqualToRect(CGRectMake(-2.5,-2.5,newObject.size.width,newObject.size.height), newObject.boundingBox), @"Adjusting the position of an object should properly adjust its bounding box.");
}

- (void) testShouldAdjustBoundingBoxWhenSettingSize
{
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];
    newObject.size = CGSizeMake(10.0,10.0);

    STAssertTrue(CGRectEqualToRect(CGRectMake(-5.0,-5.0,10.0,10.0), newObject.boundingBox), @"Adjusting the position of an object should properly adjust its bounding box.");
}

- (void) testShouldAdjustSizeWhenSettingBoundingBox
{
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];
    newObject.boundingBox = CGRectMake(10.0,10.0, 50.0, 50.0);

    STAssertTrue(CGSizeEqualToSize(CGSizeMake(50.0,50.0), newObject.size), @"Adjusting the bounding box of an object should properly adjust its size.");
}

- (void) testShouldAdjustBoundingBoxWhenSettingAnchorPoint
{
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];
    newObject.anchorPoint = CGPointMake(0.0,0.0);

    STAssertTrue(CGRectEqualToRect(CGRectMake(0.0,0.0,newObject.size.width,newObject.size.height), newObject.boundingBox), @"Adjusting the anchor point of an object should properly adjust its bounding box.");
}

#pragma mark - Notification Tests
- (void) testShouldFireNotificationWhenPositionChanges
{
    [self registerForPositionChangeNotification];
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];

    /* Not sure if I want this behavior or not... trying no for now
    STAssertFalse(self.objectSentPositionChangeNotification, @"Creating an object should not create a notification for position change.");
    */

    // object creation currently will fire this notification, so the value is reset
    self.objectSentPositionChangeNotification = NO;

    newObject.position = CGPointMake(20.0,20.0);
    STAssertTrue(self.objectSentPositionChangeNotification, @"Changing an objects position should fire the position change notification.");
}

- (void) testShouldFireNotificationWhenVelocityChanges
{
    [self registerForVelocityChangeNotification];
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];

    // object creation currently will fire this notification, so the value is reset
    self.objectSentVelocityChangeNotification = NO;

    newObject.velocity = CGPointMake(20.0,20.0);
    STAssertTrue(self.objectSentVelocityChangeNotification, @"Changing an objects velocity should fire the velocity change notification.");
}

- (void) testShouldFireNotificationWhenAccelerationChanges
{
    [self registerForAccelerationChangeNotification];
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];

    // object creation currently will fire this notification, so the value is reset
    self.objectSentAccelerationChangeNotification = NO;

    newObject.acceleration = CGPointMake(20.0,20.0);
    STAssertTrue(self.objectSentAccelerationChangeNotification, @"Changing an objects acceleration should fire the acceleration change notification.");
}

- (void) testShouldFireNotificationWhenForceChanges
{
    [self registerForForceChangeNotification];
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];

    // object creation currently will fire this notification, so the value is reset
    self.objectSentForceChangeNotification = NO;

    newObject.force = CGPointMake(20.0,20.0);
    STAssertTrue(self.objectSentForceChangeNotification, @"Changing the force should fire the force change notification.");
}

- (void) testShouldFireNotificationWhenCenterOfMassChanges
{
    [self registerForCenterOfMassChangeNotification];
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];

    // object creation currently will fire this notification, so the value is reset
    self.objectSentCenterOfMassChangeNotification = NO;

    newObject.centerOfMass = CGPointMake(1.0,0.0);
    STAssertTrue(self.objectSentCenterOfMassChangeNotification, @"Changing an objects center of mass should fire the center of mass change notification.");
}

- (void) testShouldFireNotificationWhenMassChanges
{
    [self registerForMassChangeNotification];
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];

    // object creation currently will fire this notification, so the value is reset
    self.objectSentMassChangeNotification = NO;

    newObject.mass = 13.5f;
    STAssertTrue(self.objectSentMassChangeNotification, @"Changing an objects mass should fire the mass change notification.");
}

- (void) testShouldFireNotificationWhenSizeChanges
{
    [self registerForSizeChangeNotification];
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];

    // object creation currently will fire this notification, so the value is reset
    self.objectSentSizeChangeNotification = NO;

    newObject.size = CGSizeMake(16.0,17.0);
    STAssertTrue(self.objectSentSizeChangeNotification, @"Changing an objects size should fire the size change notification.");
}

- (void) testShouldFireNotificationWhenBoundingBoxChanges
{
    [self registerForBoundingBoxChangeNotification];
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];

    // object creation currently will fire this notification, so the value is reset
    self.objectSentBoundingBoxChangeNotification = NO;

    newObject.boundingBox = CGRectMake(45,3,13,56);
    STAssertTrue(self.objectSentBoundingBoxChangeNotification, @"Changing an objects bounding box should fire the bounding box change notification.");
}

- (void) testShouldFireNotificationWhenRotationChanges
{
    [self registerForRotationChangeNotification];
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];

    // object creation currently will fire this notification, so the value is reset
    self.objectSentRotationChangeNotification = NO;

    newObject.rotation = 43.9f;
    STAssertTrue(self.objectSentRotationChangeNotification, @"Changing an objects rotation should fire the rotation change notification.");
}

- (void) testShouldFireNotificationWhenAnchorPointChanges
{
    [self registerForAnchorPointChangeNotification];
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];

    // object creation currently will fire this notification, so the value is reset
    self.objectSentAnchorPointChangeNotification = NO;

    newObject.anchorPoint = CGPointMake(1.0,0.0);
    STAssertTrue(self.objectSentAnchorPointChangeNotification, @"Changing an objects anchor point should fire the anchor point change notification.");
}

#pragma mark - Update Tests
- (void) testShouldUpdatePositionWithVelocity
{
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];
    newObject.isActive = YES;
    newObject.velocity = CGPointMake(10.0, 0.0);

    STAssertTrue(CGPointEqualToPoint(CGPointZero, newObject.position), @"Setting a velocity should not change position until update is called.");

    [newObject update:1.0];
    STAssertFalse(CGPointEqualToPoint(CGPointZero, newObject.position), @"Updating an object with a velocity should change that object's position.");
}

- (void) testShouldUpdateVelocityWithAcceleration
{
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];
    newObject.isActive = YES;
    newObject.acceleration = CGPointMake(10.0, 0.0);

    STAssertTrue(CGPointEqualToPoint(CGPointZero, newObject.velocity), @"Setting an acceleration should not change velocity until update is called.");

    [newObject update:1.0];
    STAssertFalse(CGPointEqualToPoint(CGPointZero, newObject.velocity), @"Updating an object with an acceleration should change that object's velocity.");
}

- (void) testShouldUpdateAccelerationWithForce
{
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];
    newObject.isActive = YES;
    newObject.force = CGPointMake(10.0, 0.0);

    STAssertTrue(CGPointEqualToPoint(CGPointZero, newObject.acceleration), @"Setting a force should not change acceleration until update is called.");

    [newObject update:1.0];
    STAssertFalse(CGPointEqualToPoint(CGPointZero, newObject.acceleration), @"Updating an object with a force should change that object's acceleration.");
}

- (void) testShouldZeroVelocityWhenLessThanMinimumVelocity
{
    KJPhysicsObject *newObject = [ObjectCreationHelpers createDefaultPhysicsObject];
    newObject.isActive = YES;
    newObject.velocity = CGPointMake(1.0, 0.0);
    // update with enough time for damping to reduce velocity
    [newObject update:5.0];
    STAssertTrue(newObject.minimumVelocity > sqrtf(newObject.velocity.x * newObject.velocity.x +
                                                   newObject.velocity.y * newObject.velocity.y),
                 @"Damping value of .95 should slow object enough after 5 seconds to reach minimum value.");
    [newObject update:0.0];

    STAssertTrue(CGPointEqualToPoint(CGPointZero, newObject.velocity), @"Updating an object with an acceleration should change that objects velocity.");
}
@end
