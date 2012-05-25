//
//  LevelLoader.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Level.h"

/**
 
 The LevelLoader reads in a dictionary (from a plist or other source) and creates a level object that can be more readily used by other game elements. Also manages the changing of one level to another.

 */

@interface LevelLoader : NSObject {
    
}

- (id) init;
+ (id) loader;
- (void) dealloc;

- (Level *) loadLevelFromDictionary:(NSDictionary *) dict;
- (void) transitionToLevel:(Level *) newLevel;

@end
