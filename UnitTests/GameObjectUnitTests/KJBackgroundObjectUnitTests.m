 //
//  KJBackgroundObjectUnitTests.m
//  GameEngine
//
//  Created by Kevin Jenkins on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJBackgroundObjectUnitTests.h"
#import "ObjectCreationHelpers.h"


@implementation KJBackgroundObjectUnitTests

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
    KJBackgroundObject *defaultBackgroundObject = [ObjectCreationHelpers createDefaultBackgroundObject];

    STAssertNotNil(defaultBackgroundObject, @"Default object should be created with convenience constructor.");
    STAssertNil([defaultBackgroundObject backgroundFileName], @"Default background objects should have no file name.");

}

- (void) testShouldSetUpObjectFromDictionary
{
    KJBackgroundObject *backgroundObject = [ObjectCreationHelpers createBackgroundObjectWithDictionary];

    STAssertNotNil(backgroundObject, @"Default object should be created with convenience constructor.");
    STAssertTrue([@"sampleBackgroundFileName.png" isEqualToString:[backgroundObject backgroundFileName]], @"Background objects should load from dictionary.");
}

@end
