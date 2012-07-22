//
//  KJModuleUnitTests.m
//  GameEngine
//
//  Created by Kevin Jenkins on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJModuleUnitTests.h"
#import "ObjectCreationHelpers.h"
#import "KJModule.h"

@implementation KJModuleUnitTests

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
    KJModule *module = [ObjectCreationHelpers createDefaultModule];
    STAssertTrue([@"defaultId" isEqualToString:module.moduleId], @"Default modules should have defaultId as their initial ID.");
    STAssertTrue([@"defaultClassName" isEqualToString:module.moduleName], @"Default modules should have defaultClassName set as their name.");
    STAssertTrue(nil == module.parent, @"Default modules should have no parent.");
}

- (void) testShouldCreateModuleFromDictionary
{
    KJModule *initializedModule = [ObjectCreationHelpers createModuleWithDictionary];
    STAssertTrue([@"moduleId1" isEqualToString:initializedModule.moduleId], @"Initialized modules should have defaultId as their initial ID.");
    STAssertTrue([@"baseModuleName" isEqualToString:initializedModule.moduleName], @"Initialized modules should have baseModuleName1 set as their name.");
    STAssertTrue(nil == initializedModule.parent, @"Initialized modules should have no parent.");
}

- (void) testShouldIncrementDefaultId
{
    KJModule *initializedModule1 = [ObjectCreationHelpers createIncrementingModuleWithDictionary];
    KJModule *initializedModule2 = [ObjectCreationHelpers createIncrementingModuleWithDictionary];
    STAssertTrue([@"moduleId0" isEqualToString:initializedModule1.moduleId], @"Initialized modules should have moduleId# as their ID where # is an incrementing value based on the number of modules created previously.");
    STAssertTrue([@"baseModuleName2" isEqualToString:initializedModule1.moduleName], @"Initialized modules should have baseModuleName2 set as their name.");
    STAssertTrue(nil == initializedModule1.parent, @"Initialized modules should have no parent.");

    STAssertTrue([@"moduleId1" isEqualToString:initializedModule2.moduleId], @"Initialized modules should have moduleId# as their ID where # is an incrementing value based on the number of modules created previously.");
    STAssertTrue([@"baseModuleName2" isEqualToString:initializedModule2.moduleName], @"Initialized modules should have baseModuleName2 set as their name.");
    STAssertTrue(nil == initializedModule2.parent, @"Initialized modules should have no parent.");
}

@end
