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

@interface StackManager ()

@property (nonatomic, assign) CGRect window;

@property (nonatomic, retain) SortedStack *leftStack;
@property (nonatomic, retain) SortedStack *rightStack;
@property (nonatomic, retain) SortedStack *upStack;
@property (nonatomic, retain) SortedStack *downStack;

@property (nonatomic, retain) NSMutableSet *activeObjects; 
@property (nonatomic, retain) NSMutableSet *inactiveObjects;
@property (nonatomic, retain) NSMutableSet *alwaysUpdate;

@end

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
        [self.inactiveObjects addObject:elt];
    } else {                
        
        // If we reach this point, the object must actually be in the rectangle still, activate it.
        // We may want to add a property in the element to handle cases where the object wants to destroy itself.
        [elt setActive:YES];
        [self.activeObjects addObject:elt];
    }
    
}

- (bool) didMoveToLeftOrRightStack:(NSObject<StackElementProtocol> *) elt {
    
    CGRect boundingBox = [elt boundingBox];        
    
    float xRight = boundingBox.origin.x + boundingBox.size.width;
    float xLeft = boundingBox.origin.x;
    
    if (xLeft > self.window.origin.x + self.window.size.width) {
        // add to up right
        [self.rightStack push:elt];
        return YES;
    }
    
    if (xRight < self.window.origin.x) {
        // add to down stack
        [self.leftStack push:elt];
        return YES;
    }
    
    return NO;
    
}
- (bool) didMoveToUpOrDownStack:(NSObject<StackElementProtocol> *) elt {
    
    CGRect boundingBox = [elt boundingBox];
    
    float yHi = boundingBox.origin.y + boundingBox.size.height;
    float yLo = boundingBox.origin.y;
    
    if (yLo > self.window.origin.y + self.window.size.height) {
        // add to up stack
        [self.upStack push:elt];
        return YES;
    }
    
    if (yHi < self.window.origin.y) {
        // add to down stack
        [self.downStack push:elt];
        return YES;
    }
    
    return NO;
}

- (void) updateWithLeftMovement:(NSNotification *) notification {
    // update left stack
    
    NSSet *maybeActivate = [self.leftStack popSet];
    
    for (NSObject<StackElementProtocol> *elt in maybeActivate) {
        
        if (![self didMoveToUpOrDownStack:elt]) {
            [elt setActive:YES];
            [self.activeObjects addObject:elt];
            [self.inactiveObjects removeObject:elt];
        }
        
    }
    
}
- (void) updateWithRightMovement:(NSNotification *) notification {
    // update right stack
    
    NSSet *maybeActivate = [self.rightStack popSet];
    
    for (NSObject<StackElementProtocol> *elt in maybeActivate) {
        
        if (![self didMoveToUpOrDownStack:elt]) {
            [elt setActive:YES];
            [self.activeObjects addObject:elt];
            [self.inactiveObjects removeObject:elt];
        }
        
    }
}
- (void) updateWithUpMovement:(NSNotification *) notification {
    // update up stack
    
    NSSet *maybeActivate = [self.upStack popSet];
    
    for (NSObject<StackElementProtocol> *elt in maybeActivate) {
        
        if (![self didMoveToLeftOrRightStack:elt]) {
            [elt setActive:YES];
            [self.activeObjects addObject:elt];
            [self.inactiveObjects removeObject:elt];
        }
        
    }
}
- (void) updateWithDownMovement:(NSNotification *) notification {
    // update down stack
    
    NSSet *maybeActivate = [self.downStack popSet];
    
    for (NSObject<StackElementProtocol> *elt in maybeActivate) {
        
        if (![self didMoveToLeftOrRightStack:elt]) {
            [elt setActive:YES];
            [self.activeObjects addObject:elt];
            [self.inactiveObjects removeObject:elt];
        }
        
    }
}
- (void) updateActiveWindow:(NSNotification *) notification {
    
    [self setWindow:CGRectFromString([notification object])];
    
}
@end

@implementation StackManager

@synthesize window = _window;

@synthesize leftStack = _leftStack;
@synthesize rightStack = _rightStack;
@synthesize upStack = _upStack;
@synthesize downStack = _downStack;

@synthesize activeObjects = _activeObjects;
@synthesize inactiveObjects = _inactiveObjects;
@synthesize alwaysUpdate = _alwaysUpdate;

#pragma mark Initialization/Setup/Dealloc
- (id) initWithWindow:(CGRect) rect {
    
    if (( self = [super init] )) {
        
        self.window = rect;
        
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
    
    self.activeObjects = [[NSMutableSet alloc] initWithCapacity:1000];
    self.inactiveObjects = [[NSMutableSet alloc] initWithCapacity:1000];
    self.alwaysUpdate = [[NSMutableSet alloc] initWithCapacity:1000];
    
    self.leftStack = [[SortedStack alloc] initWithDirection:ssdLeft andWindow:self.window];
    self.rightStack = [[SortedStack alloc] initWithDirection:ssdRight andWindow:self.window];
    self.upStack = [[SortedStack alloc] initWithDirection:ssdUp andWindow:self.window];
    self.downStack = [[SortedStack alloc] initWithDirection:ssdDown andWindow:self.window];
    
    // listen for notifications on cameraMovements (left, right, up, down)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWithLeftMovement:) name:eCameraMovedLeft object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWithRightMovement:) name:eCameraMovedRight object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWithUpMovement:) name:eCameraMovedUp object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWithDownMovement:) name:eCameraMovedDown object:nil];
    
    // listen for adjustements to the active window
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateActiveWindow:) name:eActiveWindowModified object:nil];
}
- (void) setWindow:(CGRect) rect {
    self.window = rect;
    [self.leftStack setWindow:self.window];
    [self.rightStack setWindow:self.window];
    [self.upStack setWindow:self.window];
    [self.downStack setWindow:self.window];
}
- (void) reset {
    [self.activeObjects removeAllObjects];
    [self.inactiveObjects removeAllObjects];
    
    [self.alwaysUpdate removeAllObjects];
    
    [self.leftStack reset];
    [self.rightStack reset];
    [self.upStack reset];
    [self.downStack reset];
}
- (void) dealloc {
    
    [self.activeObjects release];
    [self.inactiveObjects release];
    
    [self.alwaysUpdate release];
    
    [self.leftStack release];
    [self.rightStack release];
    [self.upStack release];
    [self.downStack release];
    
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
    [self.alwaysUpdate unionSet:elementSet];
}
#pragma mark -

#pragma mark Updates
- (void) updateWithTime:(ccTime) dt {
    
    // update all active game elements
    for (NSObject<StackElementProtocol> *elt in self.activeObjects) {
        if ([elt respondsToSelector:@selector(updateWithTime:)]) {
            NSLog(@"Updating %@ at %@", elt, NSStringFromCGPoint([elt position]));
            [elt update:dt];
            
            if (![elt isActive]) {
                // element has deactivated itself
                [self.activeObjects removeObject:elt];
                [self sortElement:elt];
                
            }
        }
    }
    
    for (NSObject<StackElementProtocol> *elt in self.inactiveObjects) {
        NSLog(@"Inactive: %@ at %@", elt, NSStringFromCGPoint([elt position]));
    }
    
    // update all elements in the always active set
    for (NSObject<StackElementProtocol> *elt in self.alwaysUpdate) {
        [elt update:dt];
    }
    
}
#pragma mark -

#pragma mark Info Access
- (int) objectsInStack:(sortedStackDirection) d {
    switch (d) {
        case ssdLeft:
            return [self.leftStack count];
        case ssdUp:
            return [self.upStack count];            
        case ssdRight:
            return [self.rightStack count];
        case ssdDown:
            return [self.downStack count];
        default:
            return 0;            
    }
}
#pragma mark -


@end
