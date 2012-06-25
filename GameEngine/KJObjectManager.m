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
- (void) removeObjectFromAllStateSets:(KJGameObject *) gameObject;
@end

@implementation KJObjectManager (hidden)
- (void) registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleObjectActivatedNotification:) name:kjObjectActivated object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleObjectDeactivatedNotification:) name:kjObjectDeactivated object:nil];
}
- (void) handleObjectActivatedNotification:(NSNotification *) notification
{
    KJCommonGameObject *go = [notification object];

    if ([self.inactiveObjects containsObject:go] || [self.impendingObjectsToDeactivate containsObject:go])
    {
        [self.impendingObjectsToDeactivate removeObject:go];
        [self.impendingObjectsToActivate addObject:go];
    }
}
- (void) handleObjectDeactivatedNotification:(NSNotification *) notification
{
    KJCommonGameObject *go = [notification object];

    if ([self.activeAndInWindowObjects containsObject:go] || [self.activeButNotInWindowObjects containsObject:go] || [self.impendingObjectsToActivate containsObject:go])
    {
        [self.impendingObjectsToActivate removeObject:go];
        [self.impendingObjectsToDeactivate addObject:go];
    }
}
- (void) removeObjectFromAllStateSets:(KJGameObject *) gameObject
{
    [self.activeAndInWindowObjects removeObject:gameObject];
    [self.activeButNotInWindowObjects removeObject:gameObject];
    [self.inactiveObjects removeObject:gameObject];
    [self.alwaysActiveObjects removeObject:gameObject];
    [self.impendingObjectsToActivate removeObject:gameObject];
    [self.impendingObjectsToDeactivate removeObject:gameObject];
}
@end

@implementation KJObjectManager

@synthesize currentLevel = _currentLevel;
@synthesize activeButNotInWindowObjects = _activeButNotInWindowObjects;
@synthesize activeAndInWindowObjects = _activeAndInWindowObjects;
@synthesize inactiveObjects = _inactiveObjects;
@synthesize alwaysActiveObjects = _alwaysActiveObjects;
@synthesize impendingObjectsToActivate = _impendingObjectsToActivate;
@synthesize impendingObjectsToDeactivate = _impendingObjectsToDeactivate;

- (id) init
{
    self = [super init];
    if (self)
    {
        [self registerNotifications];
        [self setup];
    }
    return self;
}
+ (id) manager
{
    return [[[KJObjectManager alloc] init] autorelease];
}
- (void) setup
{
    self.currentLevel = nil;

    self.activeAndInWindowObjects = [NSMutableSet setWithCapacity:1000];
    self.activeButNotInWindowObjects = [NSMutableSet setWithCapacity:1000];
    self.inactiveObjects = [NSMutableSet setWithCapacity:1000];
    self.alwaysActiveObjects = [NSMutableSet setWithCapacity:200];
    self.impendingObjectsToActivate = [NSMutableSet setWithCapacity:50];
    self.impendingObjectsToDeactivate = [NSMutableSet setWithCapacity:50];
}
- (id) initWithLevel:(KJLevel *) l
{
    self = [[KJObjectManager alloc] init];
    if (self != nil) { [self setupWithLevel:l]; }

    return self;
}
+ (id) managerWithLevel:(KJLevel *) l
{
    return [[[KJObjectManager alloc] initWithLevel:l] autorelease];
}
- (void) setupWithLevel:(KJLevel *) l
{
    [self setup];

    self.currentLevel = [l retain];
    [self levelChanged];
}
- (void) dealloc
{
    if (self.currentLevel != nil) { [_currentLevel release]; self.currentLevel = nil; }
    if (self.activeAndInWindowObjects != nil) { [_activeAndInWindowObjects release]; self.activeAndInWindowObjects = nil; }
    if (self.activeButNotInWindowObjects != nil) { [_activeButNotInWindowObjects release]; self.activeButNotInWindowObjects = nil; }
    if (self.alwaysActiveObjects != nil) { [_alwaysActiveObjects release]; self.alwaysActiveObjects = nil; }
    if (self.inactiveObjects != nil) { [_inactiveObjects release]; self.inactiveObjects = nil; }
    if (self.impendingObjectsToActivate != nil) { [_impendingObjectsToActivate release]; self.impendingObjectsToActivate = nil; }
    if (self.impendingObjectsToDeactivate != nil) { [_impendingObjectsToDeactivate release]; self.impendingObjectsToDeactivate = nil; }

    [super dealloc];
}
- (void) update:(double) dt
{

    [self.activeButNotInWindowObjects unionSet:self.impendingObjectsToActivate];
    [self.inactiveObjects minusSet:self.impendingObjectsToActivate];
    [self.impendingObjectsToActivate removeAllObjects];

    [self activateObjectsInWindow];
    [self deactivateObjectsNotInWindow];

    [self.inactiveObjects unionSet:self.impendingObjectsToDeactivate];
    [self.activeAndInWindowObjects minusSet:self.impendingObjectsToDeactivate];
    [self.activeButNotInWindowObjects minusSet:self.impendingObjectsToDeactivate];
    [self.impendingObjectsToDeactivate removeAllObjects];

    for (NSObject<KJGameObjectProtocol> *go in self.alwaysActiveObjects)
    {
        [go update:dt];
    }

    for (NSObject<KJGameObjectProtocol> *go in self.activeAndInWindowObjects)
    {
        [go update:dt];
    }
}
- (void) showActiveObjects
{
    NSLog(@"There are %i active objects", [self.activeAndInWindowObjects count]);
    for (NSObject<KJGameObjectProtocol> *go in self.activeAndInWindowObjects) {
        NSLog(@"Active Object[%@]: %@", go, [go objectName]);
    }
}
- (void) showAlwaysActiveObjects
{
    NSLog(@"There are %i always active objects", [self.alwaysActiveObjects count]);
    for (NSObject<KJGameObjectProtocol> *go in self.alwaysActiveObjects) {
        NSLog(@"Always Active Object[%@]: %@", go, [go objectName]);
    }
}
- (void) setLevel:(KJLevel *) l
{
    if (self.currentLevel != nil) { [self unloadCurrentLevel]; [_currentLevel release]; self.currentLevel = nil; }
    self.currentLevel = [l retain];
    [self levelChanged];
}

- (void) levelChanged
{
    // todo: Change this to reflect active/inactive, for now, everything is active

    //[self showActiveObjects];
    //[self showAlwaysActiveObjects];
    //NSLog(@"  BEFORE ^^^^^^^^^^^^^^^^ LOAD[%@] :: %@", currentLevel, [currentLevel name]);

    //int oldCount = 0;
    for (KJCommonGameObject *go in [[self.currentLevel objectDictionary] allValues]) {
        //oldCount = [self.activeObjects count];

        if ([go isAlwaysActive]) {
            [self.alwaysActiveObjects addObject:go];
        }
        else
        {
            if ([go isActive])
            {
                [self.activeButNotInWindowObjects addObject:go];
            } else {
                [self.inactiveObjects addObject:go];
            }
        }
        //NSLog(@"Adding Object[%@]: %@   (active object count was: %i   now: %i", ge, [ge objectName], oldCount, [activeObjects count]);
    }

    [self update:0.0];

    //NSLog(@" AFTER VVVVVVVVVVVVV UNLOAD[%@] :: %@", currentLevel, [currentLevel name]);
    //[self showActiveObjects];
    //[self showAlwaysActiveObjects];
}
- (void) unloadCurrentLevel
{
    //[self showActiveObjects];
    //[self showAlwaysActiveObjects];
    //NSLog(@"  BEFORE ^^^^^^^^^^^^^^^^ UNLOAD[%@] :: %@", currentLevel, [currentLevel name]);

    [self.alwaysActiveObjects removeAllObjects];
    [self.activeAndInWindowObjects removeAllObjects];
    [self.activeButNotInWindowObjects removeAllObjects];
    [self.inactiveObjects removeAllObjects];

    //NSLog(@" AFTER VVVVVVVVVVVVV UNLOAD[%@] :: %@", currentLevel, [currentLevel name]);
    //[self showActiveObjects];
    //[self showAlwaysActiveObjects];
}
- (NSSet *) allObjects
{
    return [NSSet setWithSet:[[[self.alwaysActiveObjects setByAddingObjectsFromSet:self.activeAndInWindowObjects] setByAddingObjectsFromSet:self.activeButNotInWindowObjects] setByAddingObjectsFromSet:self.inactiveObjects]];
}
- (void) activateObjectsInWindow
{
    // this will be handled by the stackmanager in the future!

    if (self.currentLevel == nil) return;

    NSSet *copyOfActiveButNotInWindowObjects = [NSSet setWithSet:self.activeButNotInWindowObjects];

    for (KJCommonGameObject *obj in copyOfActiveButNotInWindowObjects)
    {
        if (CGRectContainsPoint([self.currentLevel activeWindow], [obj position]))
        {
            [obj setInActiveWindow:YES];
            [self.activeAndInWindowObjects addObject:obj];
            [self.activeButNotInWindowObjects removeObject:obj];
        }
    }
}
- (void) deactivateObjectsNotInWindow
{
    // this will be handled by the stackmanager in the future!

    if (self.currentLevel == nil) return;

    NSSet *copyOfActiveInWindowObjects = [NSSet setWithSet:self.activeAndInWindowObjects];

    for (KJCommonGameObject *obj in copyOfActiveInWindowObjects)
    {
        if (!CGRectContainsPoint([self.currentLevel activeWindow], [obj position]))
        {
            [obj setInActiveWindow:NO];
            [self.activeButNotInWindowObjects addObject:obj];
            [self.activeAndInWindowObjects removeObject:obj];
        }
    }
}

#pragma mark - Add/Remove Object Management
- (void) addObject:(KJGameObject *) gameObject
{
    if ([gameObject isKindOfClass:[KJCamera class]]) { [self.currentLevel addCamera:(KJCamera *)gameObject]; }
    else if ([gameObject isKindOfClass:[KJLayer class]]) { [self.currentLevel addLayer:(KJLayer *)gameObject]; }
    else [self.currentLevel addObject:gameObject];

    // Add object to either the inactive list or the activeButNotInWindowList
    if ([gameObject isActive])
    {
        [self.activeButNotInWindowObjects addObject:gameObject];
    }
    else
    {
        [self.inactiveObjects addObject:gameObject];
    }

}
- (void) removeObject:(KJGameObject *) gameObject
{
    if ([gameObject isKindOfClass:[KJCamera class]]) { [self.currentLevel removeCamera:(KJCamera *)gameObject]; }
    else if ([gameObject isKindOfClass:[KJLayer class]]) { [self.currentLevel removeLayer:(KJLayer *)gameObject]; }
    else [self.currentLevel removeObject:gameObject];

    [self removeObjectFromAllStateSets:gameObject];
}
@end
