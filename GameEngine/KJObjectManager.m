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
- (void) registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleObjectActivatedNotification:) name:kjObjectActivated object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleObjectDeactivatedNotification:) name:kjObjectDeactivated object:nil];
}
- (void) handleObjectActivatedNotification:(NSNotification *) notification
{
    KJCommonGameObject *go = [notification object];
    
    [self.impendingObjectsToDeactivate removeObject:go];    
    [self.impendingObjectsToActivate addObject:go];
}
- (void) handleObjectDeactivatedNotification:(NSNotification *) notification
{
    KJCommonGameObject *go = [notification object];
    
    [self.impendingObjectsToActivate removeObject:go];
    [self.impendingObjectsToDeactivate addObject:go];
}
@end

@implementation KJObjectManager

@synthesize currentLevel = _currentLevel;
@synthesize activeObjects = _activeObjects;
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
    
    self.activeObjects = [[NSMutableSet alloc] initWithCapacity:1000];
    self.inactiveObjects = [[NSMutableSet alloc] initWithCapacity:1000];
    self.alwaysActiveObjects = [[NSMutableSet alloc] initWithCapacity:200];
    self.impendingObjectsToActivate = [[NSMutableSet alloc] initWithCapacity:50];
    self.impendingObjectsToDeactivate = [[NSMutableSet alloc] initWithCapacity:50];
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
    if (self.currentLevel != nil) { [self.currentLevel release]; self.currentLevel = nil; }
    if (self.activeObjects != nil) { [self.activeObjects release]; self.activeObjects = nil; }
    if (self.alwaysActiveObjects != nil) { [self.alwaysActiveObjects release]; self.alwaysActiveObjects = nil; }
    if (self.inactiveObjects != nil) { [self.inactiveObjects release]; self.inactiveObjects = nil; }
    if (self.impendingObjectsToActivate != nil) { [self.impendingObjectsToActivate release]; self.impendingObjectsToActivate = nil; }
    if (self.impendingObjectsToDeactivate != nil) { [self.impendingObjectsToDeactivate release]; self.impendingObjectsToDeactivate = nil; }
    
    [super dealloc];
}
- (void) update:(double) dt
{
    [self activateObjectsInWindow];

    [self.activeObjects unionSet:self.impendingObjectsToActivate];
    [self.impendingObjectsToActivate removeAllObjects];
    
    [self.inactiveObjects unionSet:self.impendingObjectsToDeactivate];
    [self.impendingObjectsToDeactivate removeAllObjects];

    for (NSObject<KJGameObjectProtocol> *go in self.alwaysActiveObjects)
    {
        [go update:dt];
    }

    for (NSObject<KJGameObjectProtocol> *go in self.activeObjects)
    {
        [go update:dt];
    }
}
- (void) showActiveObjects
{
    NSLog(@"There are %i active objects", [self.activeObjects count]);
    for (NSObject<KJGameObjectProtocol> *go in self.activeObjects) {
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
    if (self.currentLevel != nil) { [self unloadCurrentLevel]; [self.currentLevel release]; self.currentLevel = nil; }
    [self levelChanged];
    self.currentLevel = [l retain];
}
- (KJLevel *) currentLevel
{
    return self.currentLevel;
}
- (void) levelChanged
{
    // todo: Change this to reflect active/inactive, for now, everything is active
    
    //[self showActiveObjects];
    //[self showAlwaysActiveObjects];
    //NSLog(@"  BEFORE ^^^^^^^^^^^^^^^^ LOAD[%@] :: %@", currentLevel, [currentLevel name]);
    
    int oldCount = 0;
    for (KJCommonGameObject *go in [[self.currentLevel objectDictionary] allValues]) {
        oldCount = [self.activeObjects count];
        
        if ([go isAlwaysActive]) {
            [self.alwaysActiveObjects addObject:go];
        } else if ([go isActive]) {
            [self.activeObjects addObject:go];
        } else {
            [self.inactiveObjects addObject:go];
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

    [self.alwaysActiveObjects removeAllObjects];
    [self.activeObjects removeAllObjects];
    [self.inactiveObjects removeAllObjects];
    
    //NSLog(@" AFTER VVVVVVVVVVVVV UNLOAD[%@] :: %@", currentLevel, [currentLevel name]);
    //[self showActiveObjects];
    //[self showAlwaysActiveObjects];
}
- (NSSet *) allObjects
{
    return [NSSet setWithSet:[[self.alwaysActiveObjects setByAddingObjectsFromSet:self.activeObjects] setByAddingObjectsFromSet:self.inactiveObjects]];
}
- (void) activateObjectsInWindow
{
    // this will be handled by the stackmanager in the future!
    
    if (self.currentLevel == nil) return;
    
    for (KJCommonGameObject *obj in self.inactiveObjects)
    {        
        if (CGRectContainsPoint([self.currentLevel activeWindow], [obj position])) 
        {
            [obj setIsActive:YES];
        }        
    }    
}

@end
