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
    KJGraphicalObject *graphicalObject = [ObjectCreationHelpers createGraphicalObjectWithDictionary];

    STAssertTrue(graphicalObject.zOrder == graphicalObject.vertexZ, @"Objects created with a vertexZ paramter should have that value overwritten by the zOrder value if it exists.");
    STAssertTrue(1 == graphicalObject.zOrder, @"Objects created with a zOrder paramter should initialize with that value.");
    STAssertFalse([@"part1" isEqualToString:graphicalObject.primaryPart], @"Primary part should NOT be set from the object dictionary.");
    STAssertFalse(graphicalObject.shouldIgnoreBatchNodeUpdate, @"ShouldIgnoreBatchNodeUpdate should NOT be set from the object dictionary.");
}

- (void) testShouldSetupAnimationsFromDictionary
{
    KJGraphicalObject *graphicalObject = [ObjectCreationHelpers createGraphicalObjectWithDictionary];

    NSDictionary *animationDictionary = [ObjectCreationHelpers animationDictionary];
    [graphicalObject setupGraphicsWithDictionary:animationDictionary];

    STAssertTrue([@"part1" isEqualToString:graphicalObject.primaryPart], @"Primary part should be set from the animation dictionary.");
    STAssertTrue(graphicalObject.shouldIgnoreBatchNodeUpdate, @"ShouldIgnoreBatchNodeUpdate should be set from the animation dictionary.");
    STAssertTrue(2 == graphicalObject.parts.count, @"Parts should be created and added to the parts dictionary.");

}

- (void) testShouldSetSelfAsParentOfParts
{
    KJGraphicalObject *graphicalObject = [ObjectCreationHelpers createGraphicalObjectWithDictionary];

    NSDictionary *animationDictionary = [ObjectCreationHelpers animationDictionary];
    [graphicalObject setupGraphicsWithDictionary:animationDictionary];

    for (KJGraphicsPart *part in [[graphicalObject parts] allValues])
    {
        STAssertTrue(graphicalObject == [part parent], @"All parts should have their parent set to their containing KJGraphicalObject.");
    }
}

- (void) testShouldAdjustVertexZBasedOnParentLayer
{
    KJLayer *parentLayer = [ObjectCreationHelpers layerObjectFromDictionary];
    parentLayer.zOrder = 3;

    KJGraphicalObject *graphicalObject = [ObjectCreationHelpers createGraphicalObjectWithDictionary];

    float graphicalObjectVertexZ = graphicalObject.vertexZ;
    float layerObjectVertexZ = parentLayer.vertexZ;

    [graphicalObject setParent:parentLayer];

    STAssertTrue(graphicalObjectVertexZ + layerObjectVertexZ == graphicalObject.vertexZ, @"Graphical object should set vertexZ to include offset of parent layer.");
}

#pragma mark - Notification Handler Tests
- (void) testShouldRunAnimationOnSpecifiedPart
{
    KJGraphicalObject *graphicalObject = [ObjectCreationHelpers createGraphicalObjectWithDictionary];

    NSDictionary *animationDictionary = [ObjectCreationHelpers animationDictionary];
    [graphicalObject setupGraphicsWithDictionary:animationDictionary];

    KJGraphicsPart *targetPart = [graphicalObject.parts objectForKey:@"part2"];

    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    [info setObject:[NSString stringWithString:@"animation2"] forKey:kjAnimationRequest];
    [info setObject:[NSString stringWithString:@"part2"] forKey:kjTargetPart];

    [[NSNotificationCenter defaultCenter] postNotificationName:kjAnimationRequest object:graphicalObject userInfo:info];

    STAssertTrue(3 == targetPart.currentTimeLine.keyFrames.count, @"Target part should run an animation when requested.");
}

- (void) testShouldDoNothingWhenAnimationRequestedDoesNotExist
{
    KJGraphicalObject *graphicalObject = [ObjectCreationHelpers createGraphicalObjectWithDictionary];

    NSDictionary *animationDictionary = [ObjectCreationHelpers animationDictionary];
    [graphicalObject setupGraphicsWithDictionary:animationDictionary];

    KJGraphicsPart *targetPart = [graphicalObject.parts objectForKey:@"part2"];

    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    [info setObject:[NSString stringWithString:@"animation3"] forKey:kjAnimationRequest];

    [[NSNotificationCenter defaultCenter] postNotificationName:kjAnimationRequest object:graphicalObject userInfo:info];

    STAssertTrue(2 == targetPart.currentTimeLine.keyFrames.count, @"Should not run an animation when requested.");
}

- (void) testShouldDoNothingWhenAnimationRequestedDoesNotExistForPart
{
    KJGraphicalObject *graphicalObject = [ObjectCreationHelpers createGraphicalObjectWithDictionary];

    NSDictionary *animationDictionary = [ObjectCreationHelpers animationDictionary];
    [graphicalObject setupGraphicsWithDictionary:animationDictionary];

    KJGraphicsPart *targetPart = [graphicalObject.parts objectForKey:@"part2"];

    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    [info setObject:[NSString stringWithString:@"animation3"] forKey:kjAnimationRequest];
    [info setObject:[NSString stringWithString:@"part2"] forKey:kjTargetPart];

    [[NSNotificationCenter defaultCenter] postNotificationName:kjAnimationRequest object:graphicalObject userInfo:info];

    STAssertTrue(2 == targetPart.currentTimeLine.keyFrames.count, @"Target part should run an animation when requested.");
}

- (void) testShouldRunAnimationOnAllParts
{
    KJGraphicalObject *graphicalObject = [ObjectCreationHelpers createGraphicalObjectWithDictionary];

    NSDictionary *animationDictionary = [ObjectCreationHelpers animationDictionary];
    [graphicalObject setupGraphicsWithDictionary:animationDictionary];

    KJGraphicsPart *targetPartDoesNotHaveAnimation = [graphicalObject.parts objectForKey:@"part1"];
    KJGraphicsPart *targetPartHasAnimation = [graphicalObject.parts objectForKey:@"part2"];

    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    [info setObject:[NSString stringWithString:@"animation2"] forKey:kjAnimationRequest];

    [[NSNotificationCenter defaultCenter] postNotificationName:kjAnimationRequest object:graphicalObject userInfo:info];

    STAssertTrue(2 == targetPartDoesNotHaveAnimation.currentTimeLine.keyFrames.count, @"Part should not run an animation when requested if the animation does not exist for this part.");
    STAssertTrue(3 == targetPartHasAnimation.currentTimeLine.keyFrames.count, @"Part should run an animation when requested if the animation does exist for this part.");
}

#pragma mark - Update Tests
- (void) testShouldCallUpdateOnAllParts
{
    KJGraphicalObject *graphicalObject = [ObjectCreationHelpers createGraphicalObjectWithDictionary];

    NSDictionary *animationDictionary = [ObjectCreationHelpers animationDictionary];
    [graphicalObject setupGraphicsWithDictionary:animationDictionary];
    [graphicalObject setIsActive:YES];

    KJGraphicsPart *part1 = [graphicalObject.parts objectForKey:@"part1"];
    KJGraphicsPart *part2 = [graphicalObject.parts objectForKey:@"part2"];

    [graphicalObject update:.1];

    STAssertTrue(.1 == part1.currentTimeLine.currentPosition, @"All sub-parts should update when this object updates.");
    STAssertTrue(.1 == part2.currentTimeLine.currentPosition, @"All sub-parts should update when this object updates.");
}

@end
