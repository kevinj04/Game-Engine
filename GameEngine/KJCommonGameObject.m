//
//  KJCommonGameObject.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJCommonGameObject.h"


NSString *const kjParamClass = @"class";
NSString *const kjModuleList = @"modules";

@implementation KJCommonGameObject

@synthesize modules = _modules;

#pragma mark - Initialization Methods
- (id) init
{
    self = [super init];
    return self;
}
+ (id) object
{
    return [[[KJCommonGameObject alloc] init] autorelease];
}
- (void) setup
{
    [super setup];
    self.modules = [[NSMutableDictionary alloc] init];
}
- (id) initWithDictionary:(NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    return nil;
}
+ (id) objectWithDictionary:(NSDictionary *) dictionary
{
    return [[[KJCommonGameObject alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *)dictionary
{
    [super setupWithDictionary:dictionary];
}
- (void) setupModulesWithDictionary:(NSDictionary *) dictionary
{
    // override this class, call after object is instantiated.
}
- (void) dealloc
{
    if ( self.modules != nil ) { [self.modules release]; self.modules = nil; }
    [super dealloc];
}

#pragma mark - Clean up
- (void) detachAllModules
{
    for (KJModule *mod in [self.modules allValues])
    {
        [mod setParent:nil];
    }
}

#pragma mark - Update Method
- (void) update:(double) dt
{
    for (KJModule *mod in [self.modules allValues])
    {
        [mod update:dt];
    }
    [super update:dt];
}

#pragma mark - Set Parent
- (void) setParent:(KJLayer *)parent
{
    [super setParent:parent];
    
    for (KJModule *module in [self.modules allValues])
    {
        [module setLayer:parent];
    }
}

@end
