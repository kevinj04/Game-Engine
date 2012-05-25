//
//  LevelLoader.m
//  GameEngine
//
//  Created by Kevin Jenkins on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelLoader.h"

@implementation LevelLoader

- (id) init {
    
    if (( self = [super init])) {
        
        return self;
        
    } else {
        return nil;
    }
    
}

+ (id) loader {
    return [[[LevelLoader alloc] init] autorelease];
}

- (void) dealloc {
    [super dealloc];
}

- (Level *) loadLevelFromDictionary:(NSDictionary *) dict {
    
    // As objects are created, their top most classes will be initialized with the dictionary and all their attributes will be filled out.
    
    Level *newLevel = [Level levelWithDictionary:dict];
    return newLevel;
    
    
}

- (void) transitionToLevel:(Level *) newLevel {
    // override this method
}

@end
