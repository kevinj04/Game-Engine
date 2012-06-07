//
//  KJCommonGameObject.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJGraphicalObject.h"
#import "KJModule.h"

extern NSString *const kjParamClass;
extern NSString *const kjModuleList;

/** This is the base object for game development. All games using this engine should subclass this object. */

@interface KJCommonGameObject : KJGraphicalObject {
    
}

@property (nonatomic, retain) NSMutableDictionary *modules;

- (void) setupModulesWithDictionary:(NSDictionary *) dictionary;

- (void) detachAllModules;

@end
