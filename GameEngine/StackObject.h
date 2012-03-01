//
//  HCCSortedStackObject.h
//  HipsterCity
//
//  Created by Kevin Jenkins on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackElementProtocol.h"

/**
 @brief A sorted stack object is doubly linked list node.
 
 When a GameElement is off screen, it is stored in an SortedStack. This class wraps the game object and allows it to be stored in the stack and have a sorted order. This class is handled entirely by the SortedStack class, and you should never need to explicity create on of these objects.
 
 @ingroup gameManagement
 */

@interface StackObject : NSObject {    
    
    StackObject *above;
    StackObject *below;
    
    @private
    NSObject<StackElementProtocol> *element;
}


@property (nonatomic, retain) StackObject *above;
@property (nonatomic, retain) StackObject *below;

#pragma mark Initialization
- (id) initWithElement:(NSObject<StackElementProtocol> *) elt;
+ (id) objectWithElement:(NSObject<StackElementProtocol> *) elt;
- (void) reset;
- (void) dealloc;
#pragma mark -

#pragma mark Insertion/Access Methods
- (NSObject<StackElementProtocol> *) element;
- (bool) isBase;
- (bool) isTop;
#pragma mark -

@end
