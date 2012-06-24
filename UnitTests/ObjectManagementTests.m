//
//  ObjectManagementTests.m
//  GameEngine
//
//  Created by Kevin Jenkins on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjectManagementTests.h"
#import "KJObjectManager.h"
#import "KJCommonGameObject.h"
#import "KJLevel.h"

@interface ObjectManagementTests : SenTestCase

@property (strong, retain) KJObjectManager* objectManager;
@property (strong, retain) KJLevel* level;
@property (strong, retain) KJCommonGameObject* gameObject;

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

- (void)testExample
{
    STFail(@"Unit tests are not implemented yet in UnitTests");
}

- (void)testShouldActivateObjectsInWindow
{
    [self.level setActiveWindow:CGRectMake(0.0, 0.0, 480.0, 320.0)];
    
    KJCommonGameObject *gameObject = [KJCommonGameObject object];
    [gameObject setPosition:CGPointMake(100.0, 100.0)];
    [self.level addObject:gameObject];
    [gameObject setIsActive:YES];
    
    
}

@end
