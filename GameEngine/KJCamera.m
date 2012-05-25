//
//  KJCamera.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJCamera.h"

@implementation KJCamera

#pragma mark - Initialization/Setup/Dealloc
- (id) init 
{
    self = [super init];
    return self;
}
+ (id) camera 
{
    return [[[KJCamera alloc] init] autorelease];
}
- (id) initWithDictionary:(NSDictionary *)dictionary 
{
    self = [super initWithDictionary:dictionary];
    return self;
}
+ (id) cameraWithDictionary:(NSDictionary *) dictionary
{
    return [[[KJCamera alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *)dictionary 
{
    [super setupWithDictionary:dictionary];
}
- (void) dealloc
{
    [super dealloc];
}

#pragma mark Tick Method
- (void) update:(double) dt 
{
    [super update:dt];    
}

@end
