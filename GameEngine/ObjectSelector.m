//
//  ObjectSelector.m
//  GameEngine
//
//  Created by Kevin Jenkins on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjectSelector.h"

static Level *currentLevel;

@implementation ObjectSelector

+ (void) setCurrentLevel:(Level *) level {
    currentLevel = level;
}

+ (NSObject<GameElementProtocol> *) getObjectById:(NSString *)idString {
    
    if (currentLevel == nil) { return  nil; }
    
    return [[currentLevel objectDictionary] objectForKey:idString];
        
}

@end
