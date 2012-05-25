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

@synthesize modules;

#pragma mark -
#pragma mark Initialization Methods
- (id) init 
{
    if (( self = [super init] )) 
    {
        
        return self;
        
    }
    
    return nil;
}
+ (id) object 
{
    return [[[KJCommonGameObject alloc] init] autorelease];
}
- (void) setup 
{
    [super setup];
    modules = [[NSMutableDictionary alloc] init];
}
- (id) initWithDictionary:(NSDictionary *) dictionary 
{
    
    if (( self = [super initWithDictionary:dictionary] )) {
        
        return self;
    }
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
- (void) setupModulesWithDictionary:(NSDictionary *) dictionary {
    // override this class, call after object is instantiated.
}
- (void) dealloc 
{
    
    if ( modules != nil ) { [modules release]; modules = nil; }
    
    [super dealloc];
}
#pragma mark -


- (void) detachAllModules {
    
    for (KJModule *mod in [modules allValues]) {
        [mod setParent:nil];
    }
    
}


#pragma mark Tick Method
- (void) update:(double) dt 
{

    for (KJModule *mod in [modules allValues]) 
    {
        [mod update:dt];
    }
    [super update:dt];
}

- (void) setParent:(KJLayer *)parent
{
    
    [super setParent:parent];
    
    for (KJModule *module in [modules allValues]) 
    {
        [module setLayer:parent];
    }
    
    
}

@end
