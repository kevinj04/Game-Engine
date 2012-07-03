//
//  KJGraphicPartUnitTests.m
//  GameEngine
//
//  Created by Kevin Jenkins on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJGraphicPartUnitTests.h"
#import "KJGraphicsPart.h"
#import "ObjectCreationHelpers.h"

@implementation KJGraphicPartUnitTests

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
    KJGraphicsPart *defaultPart = [ObjectCreationHelpers createDefaultGraphicsPart];

    STAssertNil(defaultPart.spriteRep, @"Sprite rep should be nil by default.");
    STAssertTrue(0 == [[defaultPart.animations allValues] count], @"Animations dictionary should be empty by default.");
    STAssertNil(defaultPart.currentTimeLine, @"Current time line should be nil by default.");
    STAssertFalse(defaultPart.shouldIgnoreBoundingBoxCalculation, @"Should ignore bounding box calculation is false by default.");
    STAssertFalse(defaultPart.shouldIgnoreBatchNodeUpdate, @"Should ignore batch node updates is false by default.");

    STAssertTrue(CGPointEqualToPoint(CGPointZero, defaultPart.masterPosition), @"Master position is CGPointZero by default.");
    STAssertTrue(0.0 == defaultPart.masterRotation, @"Master rotation is 0 by default.");
    STAssertTrue(1.0 == defaultPart.masterScaleX, @"Master x-scale is 1.0 by default.");
    STAssertTrue(1.0 == defaultPart.masterScaleY, @"Master y-scale is 1.0 by default.");
    STAssertFalse(defaultPart.masterFlipX, @"Master x-flip is NO by default.");
    STAssertFalse(defaultPart.masterFlipY, @"Master y-flip is NO default.");
    STAssertTrue(0.0f == defaultPart.masterVertexZ, @"Master vertexZ is 0.0f by default.");
    STAssertTrue(0 == defaultPart.masterZOrder, @"Master zOrder is 0 by default.");

    STAssertNil(defaultPart.spriteFrameName, @"Default sprite name is nil.");
    STAssertTrue(CGPointEqualToPoint(CGPointMake(0.0, 0.0), defaultPart.position), @"Default position is CGPointZero.");
    STAssertTrue(CGRectEqualToRect(CGRectMake(0.0, 0.0, 1.0, 1.0), defaultPart.boundingBox), @"Default boundingBox is at [0 0 1 1].");
    STAssertTrue(0.0f == defaultPart.rotation, @"Default rotation is 0.0f.");
    STAssertTrue(1.0f == defaultPart.scaleX, @"Default x-scale is 1.0f.");
    STAssertTrue(1.0f == defaultPart.scaleY, @"Default y-scale is 1.0f.");
    STAssertFalse(defaultPart.flipX, @"x-flip is NO by default.");
    STAssertFalse(defaultPart.flipY, @"y-Flip is NO by default.");
    STAssertTrue(CGPointEqualToPoint(CGPointMake(0.5, 0.5), defaultPart.anchorPoint), @"Default anchor point is [0.5 0.5]");
    STAssertTrue(defaultPart.visible, @"Part is visible by default.");
    STAssertTrue(0 == defaultPart.zOrder, @"Default zOrder is 0.");
    STAssertTrue(0.0f == defaultPart.vertexZ, @"Default vertexZ is 0.0f.");
}

- (void) testShouldCreateObjectWithDictionary
{
    KJGraphicsPart *initializedPart = [ObjectCreationHelpers createGraphicsPartWithDictionary];

    STAssertTrue(2 == [[initializedPart.animations allValues] count], @"Animations dictionary should have two animations present for this part.");
}

#pragma mark - Update Tests
- (void) testShouldUpdateCurrentTimeLine
{
    KJGraphicsPart *initializedPart = [ObjectCreationHelpers createGraphicsPartWithDictionary];

    double oldTime = initializedPart.currentTimeLine.currentPosition;

    [initializedPart update:.5];

    STAssertTrue(oldTime + 0.5f == initializedPart.currentTimeLine.currentPosition, @"Current time line should have its time position updated.");
}
- (void) testShouldTweenAnimationOnUpdate
{
    KJGraphicsPart *initializedPart = [ObjectCreationHelpers createGraphicsPartWithDictionary];

    CGPoint oldPosition = initializedPart.position;

    [initializedPart update:.5];

    STAssertFalse(CGPointEqualToPoint(oldPosition, initializedPart.position), @"Current position should be tweened.");
}

@end
