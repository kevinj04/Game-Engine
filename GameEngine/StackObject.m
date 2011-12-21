//
//  HCCSortedStackObject.m
//  HipsterCity
//
//  Created by Kevin Jenkins on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StackObject.h"

@implementation StackObject

@synthesize above, below;

#pragma mark Initialization
- (id) initWithElement:(GameElement *) elt {
    
    if (( self = [super init] )) {
        
        element = [elt retain];
        above = nil;
        below = nil;
        
        [self reset];
        
        return self;
    } else {
        return nil;
    }
    
}
+ (id) objectWithElement:(GameElement *) elt {
    return [[[StackObject alloc] initWithElement:elt] autorelease];
}
- (void) reset {
    
}
- (void) dealloc {
        
    [element release];
    if (above != nil) { [above release]; }
    if (below != nil) { [below release]; }
    
    [super dealloc];
}
#pragma mark -

#pragma mark Access Methods
- (GameElement *) element {
    return element;
}
- (bool) isBase {
    return (below == nil);
}
- (bool) isTop {
    return (above == nil);
}
#pragma mark -

@end
