//
//  CameraObject.m
//  GameEngine
//
//  Created by Kevin Jenkins on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CameraObject.h"

@implementation CameraObject

- (id) initWithDictionary:(NSDictionary *)dictionary {
    if (( self = [super initWithDictionary:dictionary] )) {
        
        [self setupWithDictionary:dictionary];
        return self;
        
    } else {
        return nil;
    }
}
+ (id) objectWithDictionary:(NSDictionary *)dictionary {
    return [[[CameraObject alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *)dictionary {
    
    [super setupWithDictionary:dictionary];
    
}
- (void) dealloc {
    [super dealloc];
}

- (void) update:(double)dt {
    [super update:dt];
}

@end
