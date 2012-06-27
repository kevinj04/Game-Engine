//
//  KJGameObjectUnitTests.m
//  GameEngine
//
//  Created by Kevin Jenkins on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJGameObjectUnitTests.h"

#import "KJGameObject.h"
#import "KJLayer.h"
#import "KJObjectManager.h"

@interface KJGameObjectUnitTests ()

- (void) handleObjectActivation:(NSNotification *)notification;
- (void) handleObjectDeactivation:(NSNotification *)notification;

@property (nonatomic, assign) bool objectWasActivated;
@property (nonatomic, assign) bool objectWasDeactivated;

@end

@implementation KJGameObjectUnitTests

@synthesize objectWasActivated = _objectWasActivated;
@synthesize objectWasDeactivated = _objectWasDeactivated;

- (void)setUp
{
    [super setUp];
    self.objectWasActivated = NO;
    self.objectWasDeactivated = NO;
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
    self.objectWasActivated = YES;
}

- (void) handleObjectDeactivation:(NSNotification *) notification
{
    self.objectWasDeactivated = YES;
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
- (KJGameObject *) gameObjectFromDictionary
{
    NSString *pathToObjectDictionary = [[NSBundle bundleForClass:[self class]] pathForResource:@"sampleObjectDictionary"
                                                                       ofType:@"plist" ];
    NSDictionary *objectsDictionary = [NSDictionary dictionaryWithContentsOfFile:pathToObjectDictionary];
    NSDictionary *objectDictionary = [objectsDictionary objectForKey:[NSString stringWithString:@"gameObject"]];
    return [KJGameObject objectWithDictionary:objectDictionary];
}

- (KJLayer *) layerObjectFromDictionary
{
    NSString *pathToObjectDictionary = [[NSBundle bundleForClass:[self class]] pathForResource:@"sampleObjectDictionary"
                                                                                        ofType:@"plist" ];
    NSDictionary *objectsDictionary = [NSDictionary dictionaryWithContentsOfFile:pathToObjectDictionary];
    NSDictionary *layerDictionary = [objectsDictionary objectForKey:[NSString stringWithString:@"layerObject"]];
    return [KJLayer objectWithDictionary:layerDictionary];
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

    KJGameObject *newObject = [self gameObjectFromDictionary];
    STAssertTrue([@"objectId" isEqualToString:newObject.objectId], @"Object should load objectId from dictionary.");
    STAssertTrue([@"objectName" isEqualToString:newObject.objectName], @"Object should load objectName from dictionary.");
    STAssertTrue(1 == newObject.objectType, @"Object should load objectType from dictionary.");
    STAssertTrue([@"parentId" isEqualToString:newObject.parentId], @"Object should load parentId from dictionary.");
    STAssertFalse(newObject.isAlwaysActive, @"Object should load alwaysActive from dictionary.");
    STAssertNil(newObject.parent, @"Parent of new object should be nil.");
}

- (void)testSetParentAlsoSetsParentId
{
    KJGameObject *newObject = [self gameObjectFromDictionary];
    KJLayer *newLayer = [self layerObjectFromDictionary];

    [newObject setParent:newLayer];

    STAssertEquals(newLayer, newObject.parent, @"Parent should be set.");
    STAssertEquals(newLayer.objectId, newObject.parentId, @"Objects parentId should be set when the parent is set.");
}

- (void)testCannotAlterActiveStateOfAlwaysActiveObject
{
    KJGameObject *newObject = [self gameObjectFromDictionary];
    newObject.isAlwaysActive = YES;

    newObject.isActive = YES;
    STAssertFalse(newObject.isActive, @"Invalid setting of active state on always active object");
}

- (void)testCreatingObjectDoesNotFireNotification
{
    [self registerForActivationEvent];
    [self gameObjectFromDictionary];
    STAssertFalse(self.objectWasActivated, @"Object should not fire activation notification on creation.");
    STAssertFalse(self.objectWasDeactivated, @"Object should not fire deactivation notification on creation.");
}

- (void)testActivatingObjectFiresNotification
{
    [self registerForActivationEvent];
    KJGameObject *newObject = [self gameObjectFromDictionary];
    newObject.isActive = YES;
    STAssertTrue(self.objectWasActivated, @"Object should fire a notification when activated.");
}

- (void)testDeactivatingObjectFiresNotification
{
    [self registerForDeactivationEvent];
    KJGameObject *newObject = [self gameObjectFromDictionary];
    newObject.isActive = YES;
    newObject.isActive = NO;
    STAssertTrue(self.objectWasDeactivated, @"Object should fire a notification when deactivated.");

}
@end
