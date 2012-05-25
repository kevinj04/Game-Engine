//
//  KJObjectManager.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



#import "KJObjectManager.h"
#import "KJCommonGameObject.h"

NSString *const kjObjectActivated = @"objectActivated";
NSString *const kjObjectDeactivated = @"objectDeactivated";

@interface KJObjectManager (hidden)
- (void) registerNotifications;
- (void) handleObjectActivatedNotification:(NSNotification *) notification;
- (void) handleObjectDeactivatedNotification:(NSNotification *) notification;
@end

@implementation KJObjectManager (hidden)
- (void) registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleObjectActivatedNotification:) name:kjObjectActivated object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleObjectDeactivatedNotification:) name:kjObjectDeactivated object:nil];
}
- (void) handleObjectActivatedNotification:(NSNotification *) notification {
    KJCommonGameObject *go = [notification object];
    
    [impendingObjectsToDeactivate removeObject:go];    
    [impendingObjectsToActivate addObject:go];
    
}
- (void) handleObjectDeactivatedNotification:(NSNotification *) notification {
    KJCommonGameObject *go = [notification object];
    
    [impendingObjectsToActivate removeObject:go];
    [impendingObjectsToDeactivate addObject:go];


}
@end


@implementation KJObjectManager

@synthesize activeObjects, alwaysActiveObjects, inactiveObjects, impendingObjectsToActivate, impendingObjectsToDeactivate;

- (id) init {
    if (( self = [super init] )) {
        
        [self registerNotifications];
        [self setup];
        return self;
        
    } else {
        return nil;
    }
}
+ (id) manager {
    return [[[KJObjectManager alloc] init] autorelease];
}
- (void) setup {
    currentLevel = nil;
    
    activeObjects = [[NSMutableSet alloc] initWithCapacity:1000];
    inactiveObjects = [[NSMutableSet alloc] initWithCapacity:1000];
    alwaysActiveObjects = [[NSMutableSet alloc] initWithCapacity:200];
    impendingObjectsToActivate = [[NSMutableSet alloc] initWithCapacity:50];
    impendingObjectsToDeactivate = [[NSMutableSet alloc] initWithCapacity:50];
}

- (id) initWithLevel:(KJLevel *) l {
    self = [[KJObjectManager alloc] init];
    if (self != nil) { [self setupWithLevel:l]; }
    
    return self;
}
+ (id) managerWithLevel:(KJLevel *) l {
    return [[[KJObjectManager alloc] initWithLevel:l] autorelease];
}
- (void) setupWithLevel:(KJLevel *) l {
    [self setup];
    
    currentLevel = [l retain];
    [self levelChanged];
}

- (void) dealloc {
    if (currentLevel != nil) { [currentLevel release]; currentLevel = nil; }
    if (activeObjects != nil) { [activeObjects release]; activeObjects = nil; }
    if (alwaysActiveObjects != nil) { [alwaysActiveObjects release]; alwaysActiveObjects = nil; }
    if (inactiveObjects != nil) { [inactiveObjects release]; inactiveObjects = nil; }
    if (impendingObjectsToActivate != nil) { [impendingObjectsToActivate release]; impendingObjectsToActivate = nil; }
    if (impendingObjectsToDeactivate != nil) { [impendingObjectsToDeactivate release]; impendingObjectsToDeactivate = nil; }
    
    [super dealloc];
}

- (void) update:(double) dt {
    
    [self activateObjectsInWindow];    
    
    [activeObjects unionSet:impendingObjectsToActivate];
    [impendingObjectsToActivate removeAllObjects];
    
    [inactiveObjects unionSet:impendingObjectsToDeactivate];
    [impendingObjectsToDeactivate removeAllObjects];
    
    for (NSObject<KJGameObjectProtocol> *go in alwaysActiveObjects) {
        [go update:dt];
    }
    
    for (NSObject<KJGameObjectProtocol> *go in activeObjects) {
        [go update:dt];
    }
}

- (void) showActiveObjects {
    NSLog(@"There are %i active objects", [activeObjects count]);
    for (NSObject<KJGameObjectProtocol> *go in activeObjects) {
        NSLog(@"Active Object[%@]: %@", go, [go objectName]);
    }
}
- (void) showAlwaysActiveObjects {
    NSLog(@"There are %i always active objects", [alwaysActiveObjects count]);
    for (NSObject<KJGameObjectProtocol> *go in alwaysActiveObjects) {
        NSLog(@"Always Active Object[%@]: %@", go, [go objectName]);
    }

}

- (void) setLevel:(KJLevel *) l {
    if (currentLevel != nil) { [self unloadCurrentLevel]; [currentLevel release]; currentLevel = nil; }
    [self levelChanged];
    currentLevel = [l retain];
}
- (KJLevel *) currentLevel {
    return currentLevel;
}
- (void) levelChanged {
    
    // todo: Change this to reflect active/inactive, for now, everything is active
    
    //[self showActiveObjects];
    //[self showAlwaysActiveObjects];
    //NSLog(@"  BEFORE ^^^^^^^^^^^^^^^^ LOAD[%@] :: %@", currentLevel, [currentLevel name]);
    
    int oldCount = 0;
    for (KJCommonGameObject *go in [[currentLevel objectDictionary] allValues]) {
        oldCount = [activeObjects count];
        
        if ([go isAlwaysActive]) {
            [alwaysActiveObjects addObject:go];
        } else if ([go isActive]) {
            [activeObjects addObject:go];
        } else {
            [inactiveObjects addObject:go];
        }
        //NSLog(@"Adding Object[%@]: %@   (active object count was: %i   now: %i", ge, [ge objectName], oldCount, [activeObjects count]);
    }
    
    
    //NSLog(@" AFTER VVVVVVVVVVVVV UNLOAD[%@] :: %@", currentLevel, [currentLevel name]);
    //[self showActiveObjects];
    //[self showAlwaysActiveObjects];
    
    
}


- (void) unloadCurrentLevel 
{
    //[self showActiveObjects];
    //[self showAlwaysActiveObjects];
    //NSLog(@"  BEFORE ^^^^^^^^^^^^^^^^ UNLOAD[%@] :: %@", currentLevel, [currentLevel name]);

    [alwaysActiveObjects removeAllObjects];
    [activeObjects removeAllObjects];
    [inactiveObjects removeAllObjects];
    
    //NSLog(@" AFTER VVVVVVVVVVVVV UNLOAD[%@] :: %@", currentLevel, [currentLevel name]);
    //[self showActiveObjects];
    //[self showAlwaysActiveObjects];
    
    

}

- (NSSet *) allObjects {
    return [NSSet setWithSet:[[alwaysActiveObjects setByAddingObjectsFromSet:activeObjects] setByAddingObjectsFromSet:inactiveObjects]];
}

- (void) activateObjectsInWindow 
{
    
    // this will be handled by the stackmanager in the future!
    
    if (currentLevel == nil) return;
    
    for (KJCommonGameObject *obj in inactiveObjects)
    {
        
        if (CGRectContainsPoint([currentLevel activeWindow], [obj position])) 
        {
            [obj setIsActive:YES];
        }
        
    }
    
}

@end
