//
//  KJKeyFrameUnitTests.m
//  GameEngine
//
//  Created by Kevin Jenkins on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJKeyFrameUnitTests.h"
#import "KJKeyFrame.h"
#import "ObjectCreationHelpers.h"
#import "Universalizer.h"

@implementation KJKeyFrameUnitTests

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
    KJKeyFrame *defaultKeyFrame = [ObjectCreationHelpers createDefaultKeyFrameObject];

    STAssertTrue(0.0 == defaultKeyFrame.timePoint, @"Default key frames should have time point 0.0.");
    STAssertTrue([kjKeyFrameSpriteFrame isEqualToString:defaultKeyFrame.frame], @"Default key frames should have their frame set to a default string kjKeyFrameSpriteFrame.");
    STAssertTrue(CGPointEqualToPoint(CGPointZero, defaultKeyFrame.position), @"Default key frames should have their position set to CGPointZero.");
    STAssertTrue(0.0f == defaultKeyFrame.rotation, @"Default key frames should have their rotation set to 0.0f");
    STAssertTrue(1.0f == defaultKeyFrame.scaleX, @"Default key frames should have their x-scale set to 1.0f.");
    STAssertTrue(1.0f == defaultKeyFrame.scaleY, @"Default key frames should have their y-scale set to 1.0f.");
    STAssertFalse(defaultKeyFrame.flipX, @"Default key frames should not be x-flipped.");
    STAssertFalse(defaultKeyFrame.flipY, @"Default key frames should not be y-flipped.");
}

- (void) testShouldCreateKeyFrameFromDictionary
{
    KJKeyFrame *initializedKeyFrame = [ObjectCreationHelpers createKeyFrameWithDictionary];
    STAssertTrue(0.5 == initializedKeyFrame.timePoint, @"Default key frames should have time point 0.0.");
    STAssertTrue([@"part1_animation1_2.png" isEqualToString:initializedKeyFrame.frame], @"Default key frames should have their frame set to a default string kjKeyFrameSpriteFrame.");
    STAssertTrue(CGPointEqualToPoint([Universalizer scalePointForIPad:CGPointMake(-1.0f, 1.0f)], initializedKeyFrame.position), @"Default key frames should have their position set to CGPointZero.");
    STAssertTrue(2.0f == initializedKeyFrame.rotation, @"Default key frames should have their rotation set to 0.0f");
    STAssertTrue(1.1f == initializedKeyFrame.scaleX, @"Default key frames should have their x-scale set to 1.0f.");
    STAssertTrue(1.1f == initializedKeyFrame.scaleY, @"Default key frames should have their y-scale set to 1.0f.");
    STAssertTrue(initializedKeyFrame.flipX, @"Default key frames should not be x-flipped.");
    STAssertTrue(initializedKeyFrame.flipY, @"Default key frames should not be y-flipped.");
}

@end
