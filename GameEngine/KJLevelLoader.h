//
//  KJLevelLoader.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJLevel.h"
#import "SynthesizeSingleton.h"


/**
 
 The LevelLoader reads in a dictionary (from a plist or other source) and creates a level object that can be more readily used by other game elements. Also manages the changing of one level to another.
 
 A key concept here is that *EVERYTHING*, even menus, are 'levels'.
 
 This class should be overridden by any game that uses it to handle the explicit shift between scenes and levels. 
 
 */



@interface KJLevelLoader : NSObject

+ (id) loader;

+ (KJLevel *) loadLevelFromDictionary:(NSDictionary *) dict;
+ (void) transitionToLevel:(KJLevel *) newLevel;

@end
