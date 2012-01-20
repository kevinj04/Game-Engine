//
//  TimeLine.m
//  GameEngine
//
//  Created by Kevin Jenkins on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TimeLine.h"
#import "KeyFrame.h"

NSString *const timeLineKeyFrames = @"keyFrames";
NSString *const timeLineCurrentPosition = @"currentPosition";
NSString *const timeLineDuration = @"duration";

@implementation TimeLine

- (id) initWithDictionary:(NSDictionary *) dictionary {
    
    if (( self = [super init] )) {
        
        [self setupWithDictionary:dictionary];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) timeLineWithDictionary:(NSDictionary *) dictionary {
    return [[[TimeLine alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    keyFrames = [[NSArray alloc] init];
    currentPosition = 0.0;
    duration = 1.0;
    
    if ([dictionary objectForKey:timeLineCurrentPosition] != nil) {
        currentPosition = [[dictionary objectForKey:timeLineCurrentPosition] floatValue];
    }
    
    if ([dictionary objectForKey:timeLineDuration] != nil) {
        duration = [[dictionary objectForKey:timeLineDuration] floatValue];
    }
    
    if ([dictionary objectForKey:timeLineKeyFrames] != nil) {
        
        [keyFrames release];
        keyFrames = nil;
        
        NSArray *arr = [dictionary objectForKey:timeLineKeyFrames];
        
        NSMutableArray *tempFrames = [NSMutableArray arrayWithCapacity:[arr count]];
        
        for (NSDictionary *d in arr) {
            
            KeyFrame *frame = [KeyFrame frameWithDictionary:d];
            [tempFrames addObject:frame];
            
        }
        
        keyFrames = [[NSArray alloc] initWithArray:tempFrames];
        
    }
    
}
- (void) dealloc {
    if (keyFrames != nil) { [keyFrames release]; keyFrames = nil; }
    [super dealloc];
}

@end
