//
//  HCCSortedStack.h
//  HipsterCity
//
//  Created by Kevin Jenkins on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackObject.h"

typedef enum sortedStackDirection {
    
    ssdLeft, ssdUp, ssdRight, ssdDown
    
} sortedStackDirection;

/**
 @brief A sorted stack data structure. 
 
 This is a modified stack implementation where all nodes maintain a sorted order based on their position relative to a certain direction. Conceptually one of these stacks represents the location of objects along a cardinal direction away from a rectangular window. For example, if the stack has direction 'left', then the top of this stack will represent the object closest to the left edge of this rectangular window and base of the stack will represent the object that is furthest.
 
 Insertion into this stack can take up to linear time, but since objects that will be inserted will come from a pool of objects that are necessarily 'above' the top of the stack, the longest any insertion will take will be on the order of the number of inserted objects, not the size of this stack. In most practical cases, only one object will be inserted per update keeping this run time constant.
 
 Although you can pop a single element from this stack, the more frequently used method will be the modified popSet:. This method will return the set of elements that are now within the range of the window. It should be noted that not all elements in this returned set will be fully in bounds of the window. If this is a left or right stack, then some elements returned may be above or below the window. If they are, the UpdateManager will relocate these objects to the appropriate stack.
 
 @ingroup gameManagement
 
 */

@interface SortedStack : NSObject {
    
@private
    
    sortedStackDirection direction;
    
    StackObject *top;
    StackObject *base;
    
    int count;
    
    CGRect window;
    
}

#pragma mark Initialization
- (id) init;
- (id) initWithDirection:(sortedStackDirection) d andWindow:(CGRect) w;
+ (id) stack;
+ (id) stackWithDirection:(sortedStackDirection) d andWindow:(CGRect) w;
- (void) setup;
- (void) reset;

- (void) setWindow:(CGRect) w;
- (void) dealloc;
#pragma mark -

#pragma mark Stack Methods
- (void) push:(GameElement *) elt;
- (NSSet *) popSet;
- (StackObject *) pop;
- (StackObject *) peek;
- (int) count;
#pragma mark -

@end
