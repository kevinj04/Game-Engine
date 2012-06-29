//
//  KJPhysicsObjectUnitTests.m
//  GameEngine
//
//  Created by Kevin Jenkins on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJPhysicsObjectUnitTests.h"
#import "KJPhysicsObject.h"

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

#pragma mark - Helpers
- (KJPhysicsObject *) createDefaultObject
{
    KJPhysicsObject *newObject = [KJPhysicsObject object];
    return newObject;
}

- (KJPhysicsObject *) createObjectWithDictionary
{
    NSString *pathToObjectDictionary = [[NSBundle bundleForClass:[self class]] pathForResource:@"sampleObjectDictionary"
                                                                                        ofType:@"plist" ];
    NSDictionary *objectsDictionary = [NSDictionary dictionaryWithContentsOfFile:pathToObjectDictionary];
    NSDictionary *objectDictionary = [objectsDictionary objectForKey:[NSString stringWithString:@"gameObject"]];
    
    KJPhysicsObject *newObject = [KJPhysicsObject objectWithDictionary:objectDictionary];
    return newObject;
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
    KJPhysicsObject *newObject = [self createDefaultObject];
    
    STAssertTrue(CGPointEqualToPoint(newObject.position, CGPointZero), @"Default objects should be placed at CGPointZero");
    STAssertTrue(CGPointEqualToPoint(newObject.velocity, CGPointZero), @"Default objects should have zero velocity.");
    STAssertTrue(CGPointEqualToPoint(newObject.acceleration, CGPointZero), @"Default objects should have zero acceleration.");
    STAssertTrue(CGPointEqualToPoint(newObject.force, CGPointZero), @"Default objects should have no applied force vector when created.");
    STAssertTrue(CGPointEqualToPoint(newObject.centerOfMass, CGPointMake(0.5, 0.5)), @"Default objects should have centered center of mass.");
    STAssertTrue(CGSizeEqualToSize(newObject.size, CGSizeMake(5.0, 5.0)), @"Default object should have size 5.0x5.0.");
    STAssertTrue(CGRectEqualToRect(newObject.boundingBox, CGRectMake(-2.5,-2.5,5.0,5.0)), @"Default objects should have bounding box [-2.5 -2.5 5.0 5.0].");
    STAssertTrue(CGPointEqualToPoint(newObject.anchorPoint, CGPointMake(0.5, 0.5)), @"Default objects should have centered anchor point.");
    STAssertTrue(1.0f == newObject.mass, @"Default objects should have 1.0f mass.");
    
    STAssertTrue(0.1 == newObject.minimumVelocity, @"New objects should have minimum velocity of 0.1.");
    STAssertTrue(0.95 == newObject.dampingValue, @"New objects should have a damping value of 0.95.");
                                                                                         
}

- (void) testShouldCreateObjectWithValuesFromDictionary
{
    STFail(@"Unwritten test.");
}

#pragma mark - Setter Tests
- (void) testShouldAdjustBoundingBoxWhenSettingPosition
{
    STFail(@"Unwritten test.");
}

- (void) testShouldAdjustBoundingBoxWhenSettingSize
{
    STFail(@"Unwritten test.");
}

- (void) testShouldAdjustSizeWhenSettingBoundingBox
{
    STFail(@"Unwritten test.");
}

- (void) testShouldAdjustBoundingBoxWhenSettingAnchorPoint
{
    STFail(@"Unwritten test.");
}

#pragma mark - Notification Tests
- (void) testShouldFireNotificationWhenPositionChanges
{
    STFail(@"Unwritten test.");
}

- (void) testShouldFireNotificationWhenVelocityChanges
{
    STFail(@"Unwritten test.");
}

- (void) testShouldFireNotificationWhenAccelerationChanges
{
    STFail(@"Unwritten test.");
}

- (void) testShouldFireNotificationWhenForceChanges
{
    STFail(@"Unwritten test.");
}

- (void) testShouldFireNotificationWhenCenterOfMassChanges
{
    STFail(@"Unwritten test.");
}

- (void) testShouldFireNotificationWhenMassChanges
{
    STFail(@"Unwritten test.");
}

- (void) testShouldFireNotificationWhenSizeChanges
{
    STFail(@"Unwritten test.");
}

- (void) testShouldFireNotificationWhenBoundingBoxChanges
{
    STFail(@"Unwritten test.");
}

- (void) testShouldFireNotificationWhenRotationChanges
{
    STFail(@"Unwritten test.");
}

- (void) testShouldFireNotificationWhenAnchorPointChanges
{
    STFail(@"Unwritten test.");
}

#pragma mark - Update Tests
- (void) testShouldUpdatePositionWithVelocity
{
    STFail(@"Unwritten test.");
}

- (void) testShouldUpdateVelocityWithAcceleration
{
    STFail(@"Unwritten test.");
}

- (void) testShouldUpdateAccelerationWithForce
{
    STFail(@"Unwritten test.");
}

- (void) testShouldZeroVelocityWhenLessThanMinimumVelocity
{
    STFail(@"Unwritten test.");
}
@end