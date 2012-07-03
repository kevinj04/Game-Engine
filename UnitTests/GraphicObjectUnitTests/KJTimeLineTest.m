//
//  KJTimeLineTest.m
//  GameEngine
//
//  Created by Kevin Jenkins on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJTimeLineTest.h"
#import "KJTimeLine.h"
#import "ObjectCreationHelpers.h"

@implementation KJTimeLineTest

- (void) setUp
{
    [super setUp];
}
- (void) tearDown
{
    [super tearDown];
}

#pragma mark - Creation Tests
- (void) testShouldCreateDefaultTimeLine
{
    KJTimeLine *defaultTimeLine = [ObjectCreationHelpers createDefaultTimeLine];

    STAssertTrue(0 == defaultTimeLine.keyFrames.count, @"Default time lines should have an empty array of key frames.");
    STAssertTrue(0.0 == defaultTimeLine.currentPosition, @"Default time lines should have their current position set to 0.0 seconds.");
    STAssertTrue(1.0 == defaultTimeLine.duration, @"Default time lines should have their durations set to 1.0 seconds.");
    STAssertTrue(0 == defaultTimeLine.keyFrameIndex, @"Default time lines should have their keyFrameIndex set to 0.");
}

- (void) testShouldCreateTimeLineFromDictionary
{
    KJTimeLine *initializedTimeLine = [ObjectCreationHelpers createTimeLineWithDictionary];

    STAssertTrue(3 == initializedTimeLine.keyFrames.count, @"Initialized time lines should have an array of three key frames.");
    STAssertTrue(0.6f == initializedTimeLine.currentPosition, @"Initialized time lines should have their current position set to 0.6 seconds -> actual value: %0.2f.", initializedTimeLine.currentPosition);
    STAssertTrue(1.5 == initializedTimeLine.duration, @"Initialized time lines should have their durations set to 1.5 seconds.");
    STAssertTrue(1 == initializedTimeLine.keyFrameIndex, @"Initialized time lines should have their keyFrameIndex set to 1.");
}

#pragma mark - Update Tests
- (void) testShouldUpdateKeyFramesOnUpdate
{
    KJTimeLine *initializedTimeLine = [ObjectCreationHelpers createTimeLineWithDictionary];
    [initializedTimeLine update:1.0];

    STAssertTrue(0 == initializedTimeLine.keyFrameIndex, @"This update should cycle the keyFrameIndex back to 0.");
}

- (void) testShouldResetTimeLine
{
    KJTimeLine *initializedTimeLine = [ObjectCreationHelpers createTimeLineWithDictionary];
    [initializedTimeLine reset];

    STAssertTrue(0 == initializedTimeLine.currentPosition, @"Reset should set the current position back to 0.0.");
}

#pragma mark - Status Tests
- (void) testShouldReturnNextKeyFrame
{
    KJTimeLine *initializedTimeLine = [ObjectCreationHelpers createTimeLineWithDictionary];
    KJKeyFrame *nextKeyFrame = [initializedTimeLine nextKeyFrame];

    STAssertNotNil(nextKeyFrame, @"Next key frame is not null.");
    STAssertTrue(1.5 == nextKeyFrame.timePoint, @"Next key frame should have time point 1.5");
}

- (void) testShouldReturnPercentThroughAnimation
{
    KJTimeLine *initializedTimeLine = [ObjectCreationHelpers createTimeLineWithDictionary];
    STAssertTrue(0.6f-0.5f/(1.5f-0.5f) == [initializedTimeLine percentThroughCurrentFrame], @"Should calculate an accurate percentage through the animation.");
}

@end
