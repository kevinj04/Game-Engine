//
//  KJObjectManager.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJLevel.h"

@interface KJObjectManager : NSObject {

}

@property (nonatomic, retain) KJLevel *currentLevel;
@property (nonatomic, retain) NSMutableSet *activeAndInWindowObjects;
@property (nonatomic, retain) NSMutableSet *activeButNotInWindowObjects;
@property (nonatomic, retain) NSMutableSet *inactiveObjects;
@property (nonatomic, retain) NSMutableSet *alwaysActiveObjects;
@property (nonatomic, retain) NSMutableSet *impendingObjectsToActivate;
@property (nonatomic, retain) NSMutableSet *impendingObjectsToDeactivate;

+ (id) manager;
- (void) setup;

- (id) initWithLevel:(KJLevel *) l;
+ (id) managerWithLevel:(KJLevel *) l;
- (void) setupWithLevel:(KJLevel *) l;

- (void) dealloc;

- (void) update:(double) dt;

- (void) showActiveObjects;
- (void) showAlwaysActiveObjects;

- (void) activateObjectsInWindow;

- (void) setLevel:(KJLevel *) l;
- (void) levelChanged;
- (void) unloadCurrentLevel;

- (NSSet *) allObjects;

- (void) addObject:(KJGameObject *) gameObject;
- (void) removeObject:(KJGameObject *) gameObject;

@end
