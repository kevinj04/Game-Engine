//
//  KJGraphicalObjectUnitTests.m
//  GameEngine
//
//  Created by Kevin Jenkins on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJGraphicalObjectUnitTests.h"
#import "KJGraphicalObject.h"
#import "ObjectCreationHelpers.h"

@interface KJGraphicalObjectUnitTests ()

@end

@implementation KJGraphicalObjectUnitTests

#pragma mark - Helpers


#pragma mark - Test Life Cycle
- (void) setUp
{
    [super setUp];
}
- (void) tearDown
{
    [super tearDown];
}

#pragma mark - Creation Tests
- (void) testShouldCreateDefaultObject
{
    KJGraphicalObject *newObject = [ObjectCreationHelpers createDefaultGraphicalObject];

    STAssertTrue(1.0f == newObject.scaleX, @"Initial x-scale for a default object should be 1.0.");
    STAssertTrue(1.0f == newObject.scaleY, @"Initial y-scale for a default object should be 1.0.");
    STAssertTrue(1.0f == newObject.animationSpeed, @"Initial animation speed for a default object should be 1.0.");
    STAssertTrue(0.0f == newObject.vertexZ, @"Initial vertexZ for a default object should be 0.0f.");
    STAssertTrue(0 == newObject.zOrder, @"Initial zOrder for a default object should be 0.");
    STAssertTrue(newObject.visible, @"Graphical objects should be visible by default.");
    STAssertFalse(newObject.flipX, @"Graphical objects should not be x-flipped by default.");
    STAssertFalse(newObject.flipY, @"Graphical objects should not be y-flipped by default.");
    STAssertTrue([@"" isEqualToString:newObject.primaryPart], @"Graphical objects should have an empty string for the primary part by default.");

    STAssertNil(newObject.parts, @"Parts dictionary should be nil for a default object.");
}

- (void) testShouldSetUpObjectFromDictionary
{
    KJGraphicalObject *newObject = [ObjectCreationHelpers createGraphicalObjectWithDictionary];

    STAssertTrue(newObject.zOrder == newObject.vertexZ, @"Objects created with a vertexZ paramter should have that value overwritten by the zOrder value if it exists.");
    STAssertTrue(1 == newObject.zOrder, @"Objects created with a zOrder paramter should initialize with that value.");

}

- (void) testShouldSetupAnimationsFromDictionary
{
    STFail(@"Unwritten test.");
}

- (void) testShouldSetSelfAsParentOfParts
{
    KJLayer *parentLayer = [ObjectCreationHelpers layerObjectFromDictionary];
    STFail(@"Unwritten test.");
}

- (void) testShouldAdjustVertexZBasedOnParentLayer
{
    STFail(@"Unwritten test.");
}

#pragma mark - Notification Handler Tests
- (void) testShouldRunNotificationOnSpecifiedPart
{
    STFail(@"Unwritten test.");
}

- (void) testShouldRunNotificationOnAllParts
{
    STFail(@"Unwritten test.");
}

#pragma mark - Update Tests
- (void) testShouldCallUpdateOnAllParts
{
    STFail(@"Unwritten test.");
}

@end
