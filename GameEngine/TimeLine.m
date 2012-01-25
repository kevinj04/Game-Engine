//
//  TimeLine.m
//  GameEngine
//
//  Created by Kevin Jenkins on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TimeLine.h"

NSString *const timeLineKeyFrames = @"keyFrames";
NSString *const timeLineCurrentPosition = @"currentPosition";
NSString *const timeLineDuration = @"duration";

@interface TimeLine (private)
- (void) updateKeyFrames;
@end

@implementation TimeLine (private)
- (void) updateKeyFrames {
    
    while (currentPosition > [[self nextKeyFrame] timePoint]) {
        keyFrameIndex = (keyFrameIndex + 1) % [keyFrames count];
        
        if (currentPosition > duration) {
            currentPosition -= duration;
        }
    }
    
}
@end

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
    keyFrameIndex = 0;
    
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
    
    // if the last keyFrame's timePoint is less than the duration, we will have an infinite loop down the line...
    
    if ([[keyFrames lastObject] timePoint] < duration) {
        
        // this will create odd behavior, but should signify a bug -- 
        NSLog(@"TIMELINE SETUP ERROR: KEYFRAME TIME POINTS MAY BE OUT OF ORDER!");
        duration = [[keyFrames lastObject] timePoint];
    }
    
}
- (void) dealloc {
    if (keyFrames != nil) { [keyFrames release]; keyFrames = nil; }
    [super dealloc];
}

- (void) update:(double) dt {
    
    currentPosition += dt;
    
    [self updateKeyFrames];
    
}

- (void) reset {
    currentPosition = 0.0;
}

- (KeyFrame *) currentKeyFrame {
    if ([keyFrames count] == 0) return nil;
    return [keyFrames objectAtIndex:keyFrameIndex];
}
- (KeyFrame *) nextKeyFrame {
    if ([keyFrames count] == 0) return nil;
    return [keyFrames objectAtIndex:(keyFrameIndex+1)%[keyFrames count]];
}
- (double) percentThroughCurrentFrame {
    double base = currentPosition - [[self currentKeyFrame] timePoint];
    double startOfNext = [[self currentKeyFrame] timePoint];
    
    // check looping/mod condition
    if (startOfNext <= base) {
        startOfNext = duration;
    }
    
    return base/duration;
}

@end
