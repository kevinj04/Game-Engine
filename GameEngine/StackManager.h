//
//  HCCUpdateManager.h
//  HipsterCity
//
//  Created by Kevin Jenkins on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SortedStack.h"

/**
 @brief Manages which objects are active and inactive. Updating this manager updates all active objects.
 
 This class is a two-dimensional ordered object manager. The game world is often filled with persistent objects that may have behaviors and movements that occur offscreen. It is necessary to track these objects and update them. In larger worlds, updating objects that are distant from the screen's boundaries may be costly an pointless. The HCCUpdateManager has a reference window that should represent the region of the world that should be updating. Any objects within the bounds of this window should be considered active and their update methods should run on every iteration of the game loop.
 
 Objects that fall outside this window should be considered inactive and should not update. Some of these objects may choose to destroy themselves (projectiles or similar things) when they leave the window. Other objects will instead go dormant and await the return of the window to become active again. 
 
 To maximize efficiency and minimize unnecessary sorting and 'hit checks' for boundary conditions, a multi-stack approach has been developed. Each stack represents a set of objects that are progressively further away from one of the boundary sides of the reference window. The top of each of these stacks is the object that is closest to the respective edge. When the window moves in a certain direction, the stack or stacks (if it moves diagonally) will pop a set of elements that are now within the bounds of the window. These objects may be on screen or they may be outside the other boundary axis. 
 
 Example: An object in the left stack may also be above the reference window. However, until this object is no longer left of the window, it does not matter that it is not in the top stack. Since it still should not be in the active set. When this object is popped off during a left move update (once the window has brought it back in bounds along the horizontal axis) the manager will check to see if it is also within bounds of the window along the vertical axis. If it is, it will be added to the active set. If not, it will be added to either the up or down stack accordingly.
 
 This manager responds to the following notifications:
 - eActiveWindowModified
 - eCameraMovedLeft
 - eCameraMovedRight
 - eCameraMovedUp
 - eCameraMovedDown
 
 @ingroup gameManagement
 */

// EVENTS
extern NSString *const eMovement;
extern NSString *const eCameraMovedLeft;
extern NSString *const eCameraMovedRight;
extern NSString *const eCameraMovedUp;
extern NSString *const eCameraMovedDown;
extern NSString *const eActiveWindowModified;

@interface StackManager : NSObject {
    
@private
    CGRect window;
    
    SortedStack *leftStack;
    SortedStack *rightStack;
    SortedStack *upStack;
    SortedStack *downStack;
    
    NSMutableSet *activeObjects; 
    NSMutableSet *inactiveObjects;
    
    NSMutableSet *alwaysUpdate;
}

#pragma mark Initialization/Setup/Dealloc
- (id) initWithWindow:(CGRect) rect;
+ (id) managerWithWindow:(CGRect) rect;
- (void) setup;
- (void) setWindow:(CGRect) rect;
- (void) reset;
- (void) dealloc;
#pragma mark -

#pragma mark Add Objects
- (void) addManagedElements:(NSSet *) elementSet;
- (void) addAlwaysUpdatingElements:(NSSet *) elementSet;
#pragma mark -

#pragma mark Updates
- (void) updateWithTime:(ccTime) dt;
#pragma mark -

#pragma mark Info Access
- (int) objectsInStack:(sortedStackDirection) d;
#pragma mark -

@end
