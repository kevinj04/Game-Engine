//
//  KJLevelLoader.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJLevelLoader.h"


@implementation KJLevelLoader

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup
{
    // does nothing for now.
}

+ (id) loader 
{
    return [[[KJLevelLoader alloc] init] autorelease];
}

+ (KJLevel *) loadLevelFromDictionary:(NSDictionary *) dict 
{
    KJLevel *level = [KJLevel levelWithDictionary:dict];
    return level;
}

+ (void) transitionToLevel:(KJLevel *) newLevel
{
    // override this to handle scene transition
}

@end
