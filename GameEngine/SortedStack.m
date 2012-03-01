//
//  HCCSortedStack.m
//  HipsterCity
//
//  Created by Kevin Jenkins on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SortedStack.h"

@interface SortedStack (private)

- (void) insertToLeftStack:(StackObject *) toAdd;
- (void) insertToUpStack:(StackObject *) toAdd;
- (void) insertToRightStack:(StackObject *) toAdd;
- (void) insertToDownStack:(StackObject *) toAdd;
- (void) insertObject:(StackObject *) toAdd aboveObject:(StackObject *) targetObject;

- (NSSet *) popSetLeft;
- (NSSet *) popSetRight;
- (NSSet *) popSetUp;
- (NSSet *) popSetDown;
@end

@implementation SortedStack (private)

- (void) insertToLeftStack:(StackObject *) toAdd {
    
    NSAssert([[toAdd element] boundingBox].origin.x + [[toAdd element] boundingBox].size.width < window.origin.x, @"SHOULD NOT ADD ELEMENT TO LEFT STACK!");
    
    StackObject *obj = top;
    
    // find location in stack to insert object
    while (obj != nil && [[toAdd element] boundingBox].origin.x + [[toAdd element] boundingBox].size.width < 
           [[obj element] boundingBox].origin.x + [[obj element] boundingBox].size.width) {
        
        obj = [obj below];
        
    }
    
    [self insertObject:toAdd aboveObject:obj];
    
    
}
- (void) insertToUpStack:(StackObject *) toAdd {
    
    NSAssert([[toAdd element] boundingBox].origin.y > window.origin.y + window.size.height, @"SHOULD NOT ADD ELEMENT TO UP STACK!");
    
    StackObject *obj = top;
    
    // find location in stack to insert object
    while (obj != nil && [[toAdd element] boundingBox].origin.y > [[obj element] boundingBox].origin.y) {
        
        obj = [obj below];        
        
    }
    
    [self insertObject:toAdd aboveObject:obj];
    
}
- (void) insertToRightStack:(StackObject *) toAdd {
    
    NSAssert([[toAdd element] boundingBox].origin.x > window.origin.x + window.size.width, @"SHOULD NOT ADD ELEMENT TO RIGHT STACK!");
    
    StackObject *obj = top;
    
    // find location in stack to insert object
    while (obj != nil && [[toAdd element] boundingBox].origin.x > [[obj element] boundingBox].origin.x) {
        
        obj = [obj below];
        
    }
    
    [self insertObject:toAdd aboveObject:obj];
    
}
- (void) insertToDownStack:(StackObject *) toAdd {
    
    NSAssert([[toAdd element] boundingBox].origin.y + [[toAdd element] boundingBox].size.height < window.origin.y, @"SHOULD NOT ADD ELEMENT TO DOWN STACK!");
    
    StackObject *obj = top;
    
    // find location in stack to insert object
    while (obj != nil && [[toAdd element] boundingBox].origin.y + [[toAdd element] boundingBox].size.height < 
           [[obj element] boundingBox].origin.y + [[obj element] boundingBox].size.height) {
        
        obj = [obj below];
        
    }    
    
    [self insertObject:toAdd aboveObject:obj];
    
}

- (void) insertObject:(StackObject *) toAdd aboveObject:(StackObject *) targetObject {
    
    if (targetObject == nil) {
        // case where we are putting the object at the base of the stack
        [toAdd setAbove:base];
        [toAdd setBelow:nil];
        [base setBelow:toAdd];
        base = toAdd;        
    } else {    
        
        if (top == targetObject) {
            // case where we are putting object at the top of the stack
            top = toAdd;
            [toAdd setAbove:nil];
        } else {        
            // case where object is placed internally in the stack
            StackObject *above = [targetObject above];
            [above setBelow:toAdd];
        }
        
        [targetObject setAbove:toAdd];
        [toAdd setBelow:targetObject];
        
    }
    
}

- (NSSet *) popSetLeft {
    
    CGRect boundingBox = [[[self peek] element] boundingBox];
    
    NSMutableSet *shouldActivate = [NSMutableSet setWithCapacity:25];
    
    while (boundingBox.origin.x + boundingBox.size.width > window.origin.x) {        
        StackObject *obj = [self pop];
        if (obj == nil) { 
            break; 
        } else {
            [shouldActivate addObject:[obj element]];
        }
    }
    
    return shouldActivate;
}
- (NSSet *) popSetRight {
    
    CGRect boundingBox = [[[self peek] element] boundingBox];
    
    NSMutableSet *shouldActivate = [NSMutableSet setWithCapacity:25];
    
    while (boundingBox.origin.x < window.origin.x + window.size.width) {
        StackObject *obj = [self pop];
        if (obj == nil) { 
            break; 
        } else {
            [shouldActivate addObject:[obj element]];
        }
    }
    
    return shouldActivate;
}
- (NSSet *) popSetUp {
    
    CGRect boundingBox = [[[self peek] element] boundingBox];
    
    NSMutableSet *shouldActivate = [NSMutableSet setWithCapacity:25];
    
    while (boundingBox.origin.y < window.origin.y + window.size.height) {
        StackObject *obj = [self pop];
        if (obj == nil) { 
            break; 
        } else {
            [shouldActivate addObject:[obj element]];
        }
    }
    
    return shouldActivate;
}
- (NSSet *) popSetDown {
    CGRect boundingBox = [[[self peek] element] boundingBox];
    
    NSMutableSet *shouldActivate = [NSMutableSet setWithCapacity:25];
    
    while (boundingBox.origin.y + boundingBox.size.height > window.origin.y) {                
        
        StackObject *obj = [self pop];
        if (obj == nil) { 
            break; 
        } else {
            [shouldActivate addObject:[obj element]];
        }
    }
    
    return shouldActivate;
}

@end


@implementation SortedStack

#pragma mark Initialization
- (id) init {
    
    if (( self = [super init] )) {                        
        
        direction = ssdLeft;
        
        window = CGRectMake(0.0, 0.0, 0.0, 0.0); // no objects will be in this window;
        
        [self setup];
        
        [self reset];
        
        return self;
    } else {
        return nil;
    }
}
- (id) initWithDirection:(sortedStackDirection) d andWindow:(CGRect) w {
    
    if (( self = [super init] )) {
        
        direction = d;        
        window = w;
        
        [self setup];
        
        [self reset];
        
        return self;
    } else {
        return nil;
    }
}
+ (id) stack {
    return [[[SortedStack alloc] init] autorelease];
}
+ (id) stackWithDirection:(sortedStackDirection) d andWindow:(CGRect) w {
    return [[[SortedStack alloc] initWithDirection:d andWindow:w] autorelease];
}
- (void) setup {    
    
}
- (void) reset {
    
    if (top != nil) {
        [top release];
        top = nil;
    }
    
    count = 0;
    
}
- (void) setWindow:(CGRect) w {
    window = w;
}
- (void) dealloc {
    
    if (top != nil) { [top release]; }
    
    [super dealloc];
}
#pragma mark -

#pragma mark Stack Methods
- (void) push:(NSObject<StackElementProtocol> *) elt {
    count++;
    
    if (top == nil) { 
        top = [[StackObject objectWithElement:elt] retain]; 
        base = top;
    } else {
        
        StackObject *toAdd = [[StackObject objectWithElement:elt] retain]; 
        
        switch (direction) {
            case ssdLeft:                
                [self insertToLeftStack:toAdd];
                break;
            case ssdUp:                
                [self insertToUpStack:toAdd];
                break;
            case ssdRight:
                [self insertToRightStack:toAdd];
                break;
            case ssdDown:                
                [self insertToDownStack:toAdd];
                break;
        }
        
        
    }
    
    
}
- (StackObject *) pop {
    
    if (count == 0) { return nil; }
    
    StackObject *toReturn = top;
    
    top = [top below];
    [top setAbove:nil];
    
    count--;
    
    if (count == 0) { base = nil; }
    
    return toReturn;
    
}
- (NSSet *) popSet {
    
    if (count == 0) { return [NSSet set]; }
    
    switch (direction) {
        case ssdLeft:
            return [self popSetLeft];
        case ssdUp:
            return [self popSetUp];
        case ssdDown:
            return [self popSetDown];
        case ssdRight:
            return [self popSetRight];
    }
    return nil;
}
- (StackObject *) peek {
    if (count == 0) { return nil; }
    
    return top;
}
- (int) count {
    return count;
}
#pragma mark -

@end
