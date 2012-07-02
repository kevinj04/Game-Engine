//
//  KJGameObjectUnitTests.m
//  GameEngine
//
//  Created by Kevin Jenkins on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJGameObjectUnitTests.h"

#import "ObjectCreationHelpers.h"

#import "KJGameObject.h"
#import "KJLayer.h"
#import "KJObjectManager.h"

@interface KJGameObjectUnitTests ()

- (void) handleObjectActivation:(NSNotification *)notification;
- (void) handleObjectDeactivation:(NSNotification *)notification;
- (void) handleObjectSetAlwaysActive:(NSNotification *)notification;
- (void) handleObjectSetNotAlwaysActive:(NSNotification *)notification;

@property (nonatomic, assign) bool objectSentNotificationActivated;
@property (nonatomic, assign) bool objectSentNotificationDeactivated;
@property (nonatomic, assign) bool objectSentNotificationAlwaysActive;
@property (nonatomic, assign) bool objectSentNotificationNotAlwaysActive;

@end

@implementation KJGameObjectUnitTests

@synthesize objectSentNotificationDeactivated = _objectSentNotificationDeactivated;
@synthesize objectSentNotificationActivated = _objectSentNotificationActivated;
@synthesize objectSentNotificationAlwaysActive = _objectSentNotificationAlwaysActive;
@synthesize objectSentNotificationNotAlwaysActive = _objectSentNotificationNotAlwaysActive;

- (void)setUp
{
    [super setUp];
    self.objectSentNotificationActivated = NO;
    self.objectSentNotificationDeactivated = NO;
    self.objectSentNotificationAlwaysActive = NO;
    self.objectSentNotificationNotAlwaysActive = NO;
}

- (void)tearDown
{
    // Tear-down code here.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super tearDown];
}

#pragma mark - Event Handlers
- (void) handleObjectActivation:(NSNotification *) notification
{
    self.objectSentNotificationActivated = YES;
}

- (void) handleObjectDeactivation:(NSNotification *) notification
{
    self.objectSentNotificationDeactivated = YES;
}
- (void) handleObjectSetAlwaysActive:(NSNotification *) notification
{
    self.objectSentNotificationAlwaysActive = YES;
}
- (void) handleObjectSetNotAlwaysActive:(NSNotification *) notification
{
    self.objectSentNotificationNotAlwaysActive = YES;
}

#pragma mark - Helper functions
- (void) registerForActivationEvent
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleObjectActivation:) name:kjObjectActivated object:nil];
}
- (void) registerForDeactivationEvent
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleObjectDeactivation:) name:kjObjectDeactivated object:nil];
}
- (void) registerForSetAlwaysActiveEvent
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleObjectSetAlwaysActive:) name:kjObjectSetAlwaysActive object:nil];
}
- (void) registerForSetNotAlwaysActive
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleObjectSetNotAlwaysActive:) name:kjObjectSetNotAlwaysActive object:nil];
}

#pragma mark - Tests
- (void)testCreateDefaultObjectWithDefaultId
{
    KJGameObject *newObject = [KJGameObject object];
    STAssertTrue([@"defaultObjectId" isEqualToString:newObject.objectId], @"New Objects should have defaultId as their obejctId");
}

- (void)testDefaultNewObjectShouldNotBeActive
{
    KJGameObject *newObject = [KJGameObject object];
    STAssertFalse(newObject.isActive, @"New default game objects should be inactive.");
}

- (void)testDefaultNewObjectShouldNotBeInWindow
{
    KJGameObject *newObject = [KJGameObject object];
    STAssertFalse(newObject.inActiveWindow, @"New default game objects should not know if they are in the window.");
}

- (void)testDefaultNewObjectShouldNotBeAlwaysActive
{
    KJGameObject *newObject = [KJGameObject object];
    STAssertFalse(newObject.isAlwaysActive, @"New default game objects should not be always active.");
}

- (void)testDefaultNewObjectShouldHaveNoParent
{
    KJGameObject *newObject = [KJGameObject object];
    STAssertNil(newObject.parent, @"Parent of new object should be nil.");
}

- (void)testShouldSetupWithDictionaryValues
{

    KJGameObject *newObject = [ObjectCreationHelpers gameObjectFromDictionary];
    STAssertTrue([@"objectId" isEqualToString:newObject.objectId], @"Object should load objectId from dictionary.");
    STAssertTrue([@"objectName" isEqualToString:newObject.objectName], @"Object should load objectName from dictionary.");
    STAssertTrue(1 == newObject.objectType, @"Object should load objectType from dictionary.");
    STAssertTrue([@"parentId" isEqualToString:newObject.parentId], @"Object should load parentId from dictionary.");
    STAssertFalse(newObject.isAlwaysActive, @"Object should load alwaysActive from dictionary.");
    STAssertNil(newObject.parent, @"Parent of new object should be nil.");
}

- (void)testSetParentAlsoSetsParentId
{
    KJGameObject *newObject = [ObjectCreationHelpers gameObjectFromDictionary];
    KJLayer *newLayer = [ObjectCreationHelpers layerObjectFromDictionary];

    [newObject setParent:newLayer];

    STAssertEquals(newLayer, newObject.parent, @"Parent should be set.");
    STAssertEquals(newLayer.objectId, newObject.parentId, @"Objects parentId should be set when the parent is set.");
}

- (void)testCannotAlterActiveStateOfAlwaysActiveObject
{
    KJGameObject *newObject = [ObjectCreationHelpers gameObjectFromDictionary];
    newObject.isAlwaysActive = YES;

    newObject.isActive = YES;
    STAssertFalse(newObject.isActive, @"Invalid setting of active state on always active object");
}

- (void)testCreatingObjectDoesNotFireNotification
{
    [self registerForActivationEvent];
    [ObjectCreationHelpers gameObjectFromDictionary];
    STAssertFalse(self.objectSentNotificationActivated, @"Object should not fire activation notification on creation.");
    STAssertFalse(self.objectSentNotificationDeactivated, @"Object should not fire deactivation notification on creation.");
}

- (void)testActivatingObjectFiresNotification
{
    [self registerForActivationEvent];
    KJGameObject *newObject = [ObjectCreationHelpers gameObjectFromDictionary];
    newObject.isActive = YES;
    STAssertTrue(self.objectSentNotificationActivated, @"Object should fire a notification when activated.");
}

- (void)testDeactivatingObjectFiresNotification
{
    [self registerForDeactivationEvent];
    KJGameObject *newObject = [ObjectCreationHelpers gameObjectFromDictionary];
    newObject.isActive = YES;
    newObject.isActive = NO;
    STAssertTrue(self.objectSentNotificationDeactivated, @"Object should fire a notification when deactivated.");

}

- (void) testSetAlwaysActiveFiresNotification
{
    [self registerForSetAlwaysActiveEvent];
    KJGameObject *newObject = [ObjectCreationHelpers gameObjectFromDictionary];
    newObject.isAlwaysActive = YES;
    STAssertTrue(self.objectSentNotificationAlwaysActive, @"Object should fire a notification when set always active.");
}

- (void) testSetNotAlwaysActiveFiresNotification
{
    [self registerForSetNotAlwaysActive];
    KJGameObject *newObject = [ObjectCreationHelpers gameObjectFromDictionary];
    newObject.isAlwaysActive = YES;
    newObject.isAlwaysActive = NO;
    STAssertTrue(self.objectSentNotificationNotAlwaysActive, @"Object should fire a notification when set not always active.");
}

@end
