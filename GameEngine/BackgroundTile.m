//
//  BackgroundTile.m
//  GameEngine
//
//  Created by Kevin Jenkins on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BackgroundTile.h"

NSString *const paramImage = @"image";

@implementation BackgroundTile

@synthesize imageFileName;

- (id) initWithDictionary:(NSDictionary *) dictionary {
    
    if (( self = [super init] )) {
        
        [self setupWithDictionary:dictionary];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) tileWithDictionary:(NSDictionary *) dictionary {
    return [[[BackgroundTile alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    [super setupWithDictionary:dictionary];
    
    NSDictionary *params = [dictionary objectForKey:parameters];
    
    if ([params objectForKey:paramImage] != nil) {
        imageFileName = [[params objectForKey:paramImage] retain];
    } else {
        NSAssert(NO, @"Failed to load an image for this background object.");
    }
}
- (void) dealloc {
    
    if (imageFileName != nil) { [imageFileName release]; imageFileName = nil; }
    
    [super dealloc];
    
}

- (void) update:(double) dt {
    
    [super update:dt];
    
}

@end
