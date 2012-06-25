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

- (KJCommonGameObject *) createObjectAndWindowContext
{
    [self.level setActiveWindow:CGRectMake(0.0, 0.0, 480.0, 320.0)];

    KJCommonGameObject *gameObject = [KJCommonGameObject object];
    [gameObject setPosition:CGPointMake(100.0, 100.0)];
    [gameObject setIsActive:NO];
    [self.objectManager addObject:gameObject];

    return gameObject;
}

- (void)testShouldActivateObjectsInWindow
{
    KJCommonGameObject *gameObject = [self createObjectAndWindowContext];

    STAssertTrue(1 == self.objectManager.inactiveObjects.count, @"Game object should be in the inactive set.");
    STAssertTrue(0 == self.objectManager.impendingObjectsToActivate.count, @"Game object should not add to the active set yet.");

    [gameObject setIsActive:YES];

    STAssertTrue(0 == self.objectManager.inactiveObjects.count, @"Game objects should not be in the inactive set.");
    STAssertTrue(1 == self.objectManager.impendingObjectsToActivate.count, @"Game object should be added to the impending objects to activate set");

    // update the object manager, this should move the gameObject into the active and on screen set
    [self.objectManager update:0.0];

    STAssertTrue(0 == self.objectManager.impendingObjectsToActivate.count, @"Game object should leave the impending objects to add set");
    STAssertTrue(1 == self.objectManager.activeAndInWindowObjects.count, @"Game object should now reside in the activeAndInWindow set");
}

- (void)testShouldSetToOutOfWindowObjectsThatExitWindow
{
    KJCommonGameObject *gameObject = [self createObjectAndWindowContext];
    STAssertTrue(1 == self.objectManager.inactiveObjects.count, @"Game object should be in the inactive set.");

    [gameObject setIsActive:YES];
    [self.objectManager update:0.0];

    STAssertTrue(1 == self.objectManager.activeAndInWindowObjects.count, @"Game object should now reside in the activeAndInWindow set");
    STAssertTrue(0 == self.objectManager.activeButNotInWindowObjects.count, @"Game object should now reside in the impending objects to deactivate set");

    // move game object out of the active window
    gameObject.position = CGPointMake(500.0, 330.0);
    [self.objectManager update:0.0];

    STAssertTrue(0 == self.objectManager.activeAndInWindowObjects.count, @"Game object should now reside in the activeAndInWindow set");
    STAssertTrue(1 == self.objectManager.activeButNotInWindowObjects.count, @"Game object should now reside in the impending objects to deactivate set");

    [gameObject setIsActive:NO];
    STAssertTrue(0 == self.objectManager.activeButNotInWindowObjects.count, @"Game object should now reside in the impending objects to deactivate set");
    STAssertTrue(1 == self.objectManager.impendingObjectsToDeactivate.count, @"Game object should now reside in the impending objects to deactivate set");

    [self.objectManager update:0.0];

    STAssertTrue(0 == self.objectManager.impendingObjectsToDeactivate.count, @"Game object should now reside in the impending objects to deactivate set");
    STAssertTrue(1 == self.objectManager.inactiveObjects.count, @"Game object should now reside in the inactive set");
}

- (void)testShouldSetToOutOfWindowWhenWindowMovesAwayFromObject
{
    KJCommonGameObject *gameObject = [self createObjectAndWindowContext];
    STAssertTrue(1 == self.objectManager.inactiveObjects.count, @"Game object should be in the inactive set.");

    [gameObject setIsActive:YES];
    [self.objectManager update:0.0];

    STAssertTrue(1 == self.objectManager.activeAndInWindowObjects.count, @"Game object should now reside in the activeAndInWindow set");
    STAssertTrue(0 == self.objectManager.activeButNotInWindowObjects.count, @"Game object should now reside in the impending objects to deactivate set");

    [self.level setActiveWindow:CGRectMake(0.0, 0.0, 50.0, 50.0)];
    [self.objectManager update:0.0];

    STAssertTrue(0 == self.objectManager.activeAndInWindowObjects.count, @"Game object should now reside in the activeAndInWindow set");
    STAssertTrue(1 == self.objectManager.activeButNotInWindowObjects.count, @"Game object should now reside in the impending objects to deactivate set");

}

- (void)testShouldSetObjectInactiveWhenDeactivated
{
    KJCommonGameObject *gameObject = [self createObjectAndWindowContext];
    STAssertTrue(1 == self.objectManager.inactiveObjects.count, @"Game object should be in the inactive set.");

    [gameObject setIsActive:YES];
    [self.objectManager update:0.0];
    STAssertTrue(0 == self.objectManager.inactiveObjects.count, @"Game object should be in the inactive set.");

    [gameObject setIsActive:NO];
    [self.objectManager update:0.0];
    STAssertTrue(1 == self.objectManager.inactiveObjects.count, @"Game object should be in the inactive set.");

}

@end
