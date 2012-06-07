//
//  KJObjectManager.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJLevel.h"

extern NSString *const kjObjectActivated;
extern NSString *const kjObjectDeactivated;

@interface KJObjectManager : NSObject {
    
}

@property (nonatomic, retain) KJLevel *currentLevel;
@property (nonatomic, retain) NSMutableSet *activeObjects;
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
- (KJLevel *) currentLevel;
- (void) levelChanged;
- (void) unloadCurrentLevel;

- (NSSet *) allObjects;

@end
