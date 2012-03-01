//
//  SpriteBGObject.m
//  GameEngine
//
//  Created by Kevin Jenkins on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpriteBGObject.h"

@implementation SpriteBGObject

@synthesize backgroundFileName;

- (id) initWithDictionary:(NSDictionary *) dictionary {
 
    if (( self = [super initWithDictionary:dictionary] )) {
        
        [self setupWithDictionary:dictionary];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) objectWithDictionary:(NSDictionary *) dictionary {
    return [[[SpriteBGObject alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    [super setupWithDictionary:dictionary];
    
    
    
}
- (void) dealloc {
    
    if (backgroundFileName != nil) { [backgroundFileName release]; backgroundFileName = nil; }
    
    [super dealloc];
    
}


- (CGPoint) childBasePosition {
    return CGPointMake(0.0,0.0);
}

@end
