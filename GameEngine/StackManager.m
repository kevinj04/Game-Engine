//
//  HCCUpdateManager.m
//  HipsterCity
//
//  Created by Kevin Jenkins on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StackManager.h"

// EVENTS
NSString *const eMovement = @"movement";
NSString *const eCameraMovedLeft = @"cameraMovedLeft";
NSString *const eCameraMovedRight = @"cameraMovedRight";
NSString *const eCameraMovedUp = @"cameraMovedUp";
NSString *const eCameraMovedDown = @"cameraMovedDown";
NSString *const eActiveWindowModified = @"activeWindowModified";


@interface StackManager (private)
- (void) sortElement:(NSObject<StackElementProtocol> *) elt;

- (bool) didMoveToLeftOrRightStack:(NSObject<StackElementProtocol> *) elt;
- (bool) didMoveToUpOrDownStack:(NSObject<StackElementProtocol> *) elt;

// Event handlers for camera movement notifications.
- (void) updateWithLeftMovement:(NSNotification *) notification;
- (void) updateWithRightMovement:(NSNotification *) notification;
- (void) updateWithUpMovement:(NSNotification *) notification;
- (void) updateWithDownMovement:(NSNotification *) notification;

- (void) updateActiveWindow:(NSNotification *) notification;
@end

@implementation StackManager (private)
- (void) sortElement:(NSObject<StackElementProtocol> *) elt {
    
    if ([self didMoveToLeftOrRightStack:elt] || [self didMoveToUpOrDownStack:elt]) {
        // There may be a problem here, check to make sure the above two functions only push the elt onto one stack.            
        [inactiveObjects addObject:elt];
    } else {                
        
        // If we reach this point, the object must actually be in the rectangle still, activate it.
        // We may want to add a property in the element to handle cases where the object wants to destroy itself.
        [elt setActive:YES];
        [activeObjects addObject:elt];
    }
    
}

- (bool) didMoveToLeftOrRightStack:(NSObject<StackElementProtocol> *) elt {
    
    CGRect boundingBox = [elt boundingBox];        
    
    float xRight = boundingBox.origin.x + boundingBox.size.width;
    float xLeft = boundingBox.origin.x;
    
    if (xLeft > window.origin.x + window.size.width) {
        // add to up right
        [rightStack push:elt];
        return YES;
    }
    
    if (xRight < window.origin.x) {
        // add to down stack
        [leftStack push:elt];
        return YES;
    }
    
    return NO;
    
}
- (bool) didMoveToUpOrDownStack:(NSObject<StackElementProtocol> *) elt {
    
    CGRect boundingBox = [elt boundingBox];
    
    float yHi = boundingBox.origin.y + boundingBox.size.height;
    float yLo = boundingBox.origin.y;
    
    if (yLo > window.origin.y + window.size.height) {
        // add to up stack
        [upStack push:elt];
        return YES;
    }
    
    if (yHi < window.origin.y) {
        // add to down stack
        [downStack push:elt];
        return YES;
    }
    
    return NO;
}

- (void) updateWithLeftMovement:(NSNotification *) notification {
    // update left stack
    
    NSSet *maybeActivate = [leftStack popSet];
    
    for (NSObject<StackElementProtocol> *elt in maybeActivate) {
        
        if (![self didMoveToUpOrDownStack:elt]) {
            [elt setActive:YES];
            [activeObjects addObject:elt];
            [inactiveObjects removeObject:elt];
        }
        
    }
    
}
- (void) updateWithRightMovement:(NSNotification *) notification {
    // update right stack
    
    NSSet *maybeActivate = [rightStack popSet];
    
    for (NSObject<StackElementProtocol> *elt in maybeActivate) {
        
        if (![self didMoveToUpOrDownStack:elt]) {
            [elt setActive:YES];
            [activeObjects addObject:elt];
            [inactiveObjects removeObject:elt];
        }
        
    }
}
- (void) updateWithUpMovement:(NSNotification *) notification {
    // update up stack
    
    NSSet *maybeActivate = [upStack popSet];
    
    for (NSObject<StackElementProtocol> *elt in maybeActivate) {
        
        if (![self didMoveToLeftOrRightStack:elt]) {
            [elt setActive:YES];
            [activeObjects addObject:elt];
            [inactiveObjects removeObject:elt];
        }
        
    }
}
- (void) updateWithDownMovement:(NSNotification *) notification {
    // update down stack
    
    NSSet *maybeActivate = [downStack popSet];
    
    for (NSObject<StackElementProtocol> *elt in maybeActivate) {
        
        if (![self didMoveToLeftOrRightStack:elt]) {
            [elt setActive:YES];
            [activeObjects addObject:elt];
            [inactiveObjects removeObject:elt];
        }
        
    }
}
- (void) updateActiveWindow:(NSNotification *) notification {
    
    [self setWindow:CGRectFromString([notification object])];
    
}
@end

@implementation StackManager

#pragma mark Initialization/Setup/Dealloc
- (id) initWithWindow:(CGRect) rect {
    
    if (( self = [super init] )) {
        
        window = rect;
        
        [self setup];
        
        [self reset];
        
        return self;
    } else {
        return nil;
    }
    
}
+ (id) managerWithWindow:(CGRect) rect {
    return [[[StackManager alloc] initWithWindow:rect] autorelease];
}
- (void) setup {
    
    // maybe bump this up?
    /*
     activeObjects = [[NSMutableSet alloc] initWithCapacity:1000];
     inactiveObjects = [[NSMutableSet alloc] initWithCapacity:1000];
     alwaysUpdate = [[NSMutableSet alloc] initWithCapacity:100];
     */
    
    activeObjects = [[NSMutableSet alloc] initWithCapacity:1000];
    inactiveObjects = [[NSMutableSet alloc] initWithCapacity:1000];
    alwaysUpdate = [[NSMutableSet alloc] initWithCapacity:1000];
    
    leftStack = [[SortedStack alloc] initWithDirection:ssdLeft andWindow:window];
    rightStack = [[SortedStack alloc] initWithDirection:ssdRight andWindow:window];
    upStack = [[SortedStack alloc] initWithDirection:ssdUp andWindow:window];
    downStack = [[SortedStack alloc] initWithDirection:ssdDown andWindow:window];
    
    // listen for notifications on cameraMovements (left, right, up, down)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWithLeftMovement:) name:eCameraMovedLeft object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWithRightMovement:) name:eCameraMovedRight object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWithUpMovement:) name:eCameraMovedUp object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWithDownMovement:) name:eCameraMovedDown object:nil];
    
    // listen for adjustements to the active window
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateActiveWindow:) name:eActiveWindowModified object:nil];
}
- (void) setWindow:(CGRect) rect {
    window = rect;
    [leftStack setWindow:window];
    [rightStack setWindow:window];
    [upStack setWindow:window];
    [downStack setWindow:window];
}
- (void) reset {
    [activeObjects removeAllObjects];
    [inactiveObjects removeAllObjects];
    
    [alwaysUpdate removeAllObjects];
    
    [leftStack reset];
    [rightStack reset];
    [upStack reset];
    [downStack reset];
}
- (void) dealloc {
    
    [activeObjects release];
    [inactiveObjects release];
    
    [alwaysUpdate release];
    
    [leftStack release];
    [rightStack release];
    [upStack release];
    [downStack release];
    
    [super dealloc];
}
#pragma mark -

#pragma mark Add Objects
- (void) addManagedElements:(NSSet *) elementSet {
    
    // Each element must be added to a stack and the inactive set or the active set.
    
    //[self updateActiveWindow:nil];
    
    for (NSObject<StackElementProtocol> *elt in elementSet) {
        
        // sortElement determines which stack and set to place the object into.
        [self sortElement:elt];
        
    }
    
}
- (void) addAlwaysUpdatingElements:(NSSet *) elementSet {    
    [alwaysUpdate unionSet:elementSet];
}
#pragma mark -

#pragma mark Updates
- (void) updateWithTime:(ccTime) dt {
    
    // update all active game elements
    for (NSObject<StackElementProtocol> *elt in activeObjects) {
        if ([elt respondsToSelector:@selector(updateWithTime:)]) {
            NSLog(@"Updating %@ at %@", elt, NSStringFromCGPoint([elt position]));
            [elt update:dt];
            
            if (![elt isActive]) {
                // element has deactivated itself
                [activeObjects removeObject:elt];
                [self sortElement:elt];
                
            }
        }
    }
    
    for (NSObject<StackElementProtocol> *elt in inactiveObjects) {
        NSLog(@"Inactive: %@ at %@", elt, NSStringFromCGPoint([elt position]));
    }
    
    // update all elements in the always active set
    for (NSObject<StackElementProtocol> *elt in alwaysUpdate) {
        [elt update:dt];
    }
    
}
#pragma mark -

#pragma mark Info Access
- (int) objectsInStack:(sortedStackDirection) d {
    switch (d) {
        case ssdLeft:
            return [leftStack count];
        case ssdUp:
            return [upStack count];            
        case ssdRight:
            return [rightStack count];
        case ssdDown:
            return [downStack count];
        default:
            return 0;            
    }
}
#pragma mark -


@end
