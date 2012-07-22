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
    self.modules = [NSMutableDictionary dictionary];
}
- (id) initWithDictionary:(NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    return self;
}
+ (id) objectWithDictionary:(NSDictionary *) dictionary
{
    return [[[KJCommonGameObject alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *)dictionary
{
    if (nil == dictionary) return;
    [super setupWithDictionary:dictionary];

    NSDictionary *params;
    NSDictionary *moduleList;
    if ((params = [dictionary objectForKey:kjParameters]))
    {
        if ((moduleList = [params objectForKey:kjModuleList]))
        {
            [self setupModulesWithDictionary:moduleList];
        }
    }
}
- (void) setupModulesWithDictionary:(NSDictionary *) dictionary
{
    for (NSDictionary *moduleInfo in [dictionary allValues])
    {
        NSString *moduleClass;
        KJModule *module;
        if ((moduleClass = [moduleInfo objectForKey:kjParamClass]))
        {

            module = [NSClassFromString(moduleClass) moduleWithDictionary:moduleInfo];

            if (module != nil) {

                [module setupWithGameObject:self];
                [self.modules setObject:module forKey:[module moduleId]];
            } else {
                NSLog(@"Attempted to create module of class %@", moduleClass);
            }
        }
    }
}
- (void) dealloc
{
    if ( self.modules != nil ) { [_modules release]; _modules = nil; }
    [super dealloc];
}

#pragma mark - Module Management
- (void) attachModule:(KJModule *)module
{
    [module setParent:self];

    if ([self.modules objectForKey:module.moduleId])
    {
        NSLog(@"KJCommongGameObject Warning: Adding duplicate module %@", module.moduleId);
    }

    [self.modules setObject:module forKey:module.moduleId];
}
- (void) detachModule:(KJModule*)module
{
    if ([[self.modules allValues] containsObject:module])
    {
        [module setParent:nil];
        [self.modules removeObjectForKey:module.moduleId];
    }
}
- (void) detachModuleWithId:(NSString*)moduleId
{
    if ([self.modules objectForKey:moduleId])
    {
        KJModule* module = [self.modules objectForKey:moduleId];
        [module setParent:nil];
        [self.modules removeObjectForKey:module.moduleId];
    }
}
- (void) detachAllModules
{
    for (KJModule *mod in [self.modules allValues])
    {
        [mod setParent:nil];
    }
    [self.modules removeAllObjects];
}

#pragma mark - Update Method
- (void) update:(double) dt
{
    if (self.inActiveWindow || self.isAlwaysActive)
    {
        for (KJModule *mod in [self.modules allValues])
        {
            [mod update:dt];
        }
    }
    [super update:dt];
}

#pragma mark - Set Parent
- (void) setParent:(KJLayer *)parent
{
    [super setParent:parent];

    for (KJModule *module in [self.modules allValues])
    {
        [module setParentLayer:parent];
    }
}

@end
