//
//  ObjectManagementTests.m
//  GameEngine
//
//  Created by Kevin Jenkins on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjectManagementTests.h"

#import "kjEngine.h"

@interface ObjectManagementTests ()

@property (nonatomic, retain) KJObjectManager* objectManager;
@property (nonatomic, retain) KJLevel* level;
@property (nonatomic, retain) KJCommonGameObject* gameObject;

@end


@implementation ObjectManagementTests

@synthesize objectManager = _objectManager;
@synthesize level = _level;
@synthesize gameObject = _gameObject;

- (void)setUp
{
    [super setUp];

    self.level = [KJLevel levelWithDictionary:nil];
    self.objectManager = [KJObjectManager manager];
    [self.objectManager setLevel:self.level];

    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.

    [super tearDown];
}

- (void) createWindowContext
{
    [self.level setActiveWindow:CGRectMake(0.0, 0.0, 480.0, 320.0)];
}
- (KJCommonGameObject *) createInactiveAndOutOfWindowObject
{
    KJCommonGameObject *gameObject = [KJCommonGameObject object];
    [gameObject setPosition:CGPointMake(100.0, 100.0)];
    [gameObject setIsActive:NO];
    [self.objectManager addObject:gameObject];
    [self.objectManager update:0.0];
    return gameObject;
}

- (KJCommonGameObject *) createInactiveButInWindowObject
{
    KJCommonGameObject *gameObject = [KJCommonGameObject object];
    [gameObject setPosition:CGPointMake(500.0, 100.0)];
    [gameObject setIsActive:NO];
    [self.objectManager addObject:gameObject];
    [self.objectManager update:0.0];
    return gameObject;
}

- (KJCommonGameObject *) createActiveAndInWindowObject
{
    KJCommonGameObject *gameObject = [KJCommonGameObject object];
    [gameObject setPosition:CGPointMake(100.0, 100.0)];
    [gameObject setIsActive:YES];
    [self.objectManager addObject:gameObject];
    [self.objectManager update:0.0];
    return gameObject;
}

- (KJCommonGameObject *) createActiveButOutOfWindowObject
{
    KJCommonGameObject *gameObject = [KJCommonGameObject object];
    [gameObject setPosition:CGPointMake(500.0, 100.0)];
    [gameObject setIsActive:YES];
    [self.objectManager addObject:gameObject];
    [self.objectManager update:0.0];
    return gameObject;
}



- (void)testShouldNotActivateInactiveObjects
{
    [self createWindowContext];
    [self createInactiveButInWindowObject];
    [self createInactiveAndOutOfWindowObject];
    [self.objectManager update:0.0];

    STAssertTrue(2 == self.objectManager.inactiveObjects.count &&
                 0 == self.objectManager.impendingObjectsToActivate.count,
                 @"Game objects should be in the inactive set.");
}

- (void)testActivatedObjectsShouldBePlacedInImpendingActivationSet
{
    [self createWindowContext];
    KJCommonGameObject *gameObject1 = [self createInactiveButInWindowObject];
    KJCommonGameObject *gameObject2 = [self createInactiveAndOutOfWindowObject];

    [gameObject1 setIsActive:YES];
    [gameObject2 setIsActive:YES];

    STAssertTrue(2 == self.objectManager.impendingObjectsToActivate.count &&
                 0 == self.objectManager.inactiveObjects.count,
                 @"Game objects should not be in the inactive set.");
}

- (void)testShouldActivateImpendingObjectsOnUpdate
{
    [self createWindowContext];
    KJCommonGameObject *gameObject1 = [self createInactiveButInWindowObject];
    KJCommonGameObject *gameObject2 = [self createInactiveAndOutOfWindowObject];

    [gameObject1 setIsActive:YES];
    [gameObject2 setIsActive:YES];

    // update the object manager, this should move the gameObject into the active and on screen set
    [self.objectManager update:0.0];

    STAssertTrue(1 == self.objectManager.activeAndInWindowObjects.count &&
                 1 == self.objectManager.activeButNotInWindowObjects.count &&
                 0 == self.objectManager.impendingObjectsToActivate.count,
                 @"Game object should leave the impending objects to add set");
}

- (void)testShouldMoveActiveInWindowObjectsToOutOfWindowSet
{
    [self createWindowContext];
    KJCommonGameObject *gameObject = [self createActiveAndInWindowObject];

    // move game object out of the active window
    gameObject.position = CGPointMake(500.0, 330.0);
    [self.objectManager update:0.0];

    STAssertTrue(1 == self.objectManager.activeButNotInWindowObjects.count &&
                 0 == self.objectManager.activeAndInWindowObjects.count,
                 @"Game object should now reside in the activeAndInWindow set");
}

- (void)testShouldSetToOutOfWindowWhenWindowMovesAwayFromObject
{
    [self createWindowContext];
    [self createActiveAndInWindowObject];

    [self.level setActiveWindow:CGRectMake(-400.0, 0.0, 480.0, 320.0)];
    [self.objectManager update:0.0];

    STAssertTrue(1 == self.objectManager.activeButNotInWindowObjects.count &&
                 0 == self.objectManager.activeAndInWindowObjects.count,
                 @"Game object should now reside in the activeAndInWindow set");
}


- (void)testShouldSetImpendingDeactivation
{
    [self createWindowContext];
    KJCommonGameObject *gameObject1 = [self createActiveAndInWindowObject];
    KJCommonGameObject *gameObject2 = [self createActiveButOutOfWindowObject];

    [gameObject1 setIsActive:NO];
    [gameObject2 setIsActive:NO];

    STAssertTrue(2 == self.objectManager.impendingObjectsToDeactivate.count &&
                 0 == self.objectManager.activeAndInWindowObjects.count,
                 @"Game objects should be set to impending deactivation");
}

- (void)testShouldSetObjectInactiveWhenDeactivated
{

    KJCommonGameObject *gameObject1 = [self createActiveAndInWindowObject];
    KJCommonGameObject *gameObject2 = [self createActiveButOutOfWindowObject];

    [gameObject1 setIsActive:NO];
    [gameObject2 setIsActive:NO];

    [self.objectManager update:0.0];
    STAssertTrue(2 == self.objectManager.inactiveObjects.count &&
                 0 == self.objectManager.activeAndInWindowObjects.count &&
                 0 == self.objectManager.activeButNotInWindowObjects.count,
                 @"Game objects should be in the inactive set.");


}


@end
