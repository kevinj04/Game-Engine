//
//  KJBackgroundObject.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJBackgroundObject.h"
#import "Universalizer.h"

NSString *const kjImage = @"image";

@implementation KJBackgroundObject

@synthesize backgroundFileName;

#pragma mark -
#pragma mark Initialization Methods
- (id) initWithDictionary:(NSDictionary *) dictionary 
{
    
    if (( self = [super init] )) {
        
        [self setupWithDictionary:dictionary];
        return self;
    }
    return nil;
}
+ (id) tileWithDictionary:(NSDictionary *) dictionary {
    return [[[KJBackgroundObject alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    [super setupWithDictionary:dictionary];
    
    NSDictionary *params = [dictionary objectForKey:kjParameters];
    
    if ([params objectForKey:kjImage] != nil) {
        backgroundFileName = [[params objectForKey:kjImage] retain];
    } else {
        NSAssert(NO, @"Failed to load an image for this background object.");
    }
    
    position = CGPointMake(0.0, 0.0);
    if ([params objectForKey:kjParameters] != nil) {
        position = [Universalizer scalePointForIPad:CGPointFromString([params objectForKey:kjObjectPosition])];
    }
    
    
}
- (void) dealloc {
    
    if (backgroundFileName != nil) { [backgroundFileName release]; backgroundFileName = nil; }
    
    [super dealloc];
}
#pragma mark -

#pragma mark Tick Method
- (void) update:(double) dt {
    
    
    [super update:dt];
}

@end
