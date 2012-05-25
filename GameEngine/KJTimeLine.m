//
//  KJTimeLine.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJTimeLine.h"

NSString *const kjTimeLineKeyFrames = @"keyFrames";
NSString *const kjTimeLineCurrentPosition = @"currentPosition";
NSString *const kjTimeLineDuration = @"duration";

@interface KJTimeLine (private)
- (void) updateKeyFrames;
@end

@implementation KJTimeLine (private)
- (void) updateKeyFrames {
    
    if ([keyFrames count] == 1) {
        keyFrameIndex = 0;
        return; // avoids a loop below if we only have one keyframe
    }
    
    while (currentPosition > [[self nextKeyFrame] timePoint]) {
        keyFrameIndex = (keyFrameIndex + 1) % [keyFrames count];
        
        if (keyFrameIndex == 0 & [keyFrames count] > 1) {
            currentPosition -= duration;
        }        
    }
    
}
@end

@implementation KJTimeLine

#pragma mark -
#pragma mark Initialization Methods
- (id) initWithDictionary:(NSDictionary *) dictionary 
{
    if (( self = [super init] )) {
        
        [self setupWithDictionary:dictionary];
        return self;
        
    } else {
        return nil;
    }
}
+ (id) timeLineWithDictionary:(NSDictionary *) dictionary 
{
    return [[[KJTimeLine alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary
{
    keyFrames = [[NSArray alloc] init];
    currentPosition = 0.0;
    duration = 1.0;
    keyFrameIndex = 0;
    
    if ([dictionary objectForKey:kjTimeLineCurrentPosition] != nil) {
        currentPosition = [[dictionary objectForKey:kjTimeLineCurrentPosition] floatValue];
    }
    
    if ([dictionary objectForKey:kjTimeLineDuration] != nil) {
        duration = [[dictionary objectForKey:kjTimeLineDuration] floatValue];
    }
    
    if ([dictionary objectForKey:kjTimeLineKeyFrames] != nil) {
        
        [keyFrames release];
        keyFrames = nil;
        
        NSArray *arr = [dictionary objectForKey:kjTimeLineKeyFrames];
        
        NSMutableArray *tempFrames = [NSMutableArray arrayWithCapacity:[arr count]];
        
        for (NSDictionary *d in arr) {
            
            KJKeyFrame *frame = [KJKeyFrame frameWithDictionary:d];
            [tempFrames addObject:frame];
            
        }
        
        keyFrames = [[NSArray alloc] initWithArray:tempFrames];
        
    }

}
- (void) dealloc 
{
    if (keyFrames != nil) { [keyFrames release]; keyFrames = nil; }
    [super dealloc];
}

#pragma mark -

#pragma mark Tick Method
- (void) update:(double) dt 
{
    currentPosition += dt;    
    [self updateKeyFrames];
}
#pragma mark -

#pragma mark Helper Methods
- (void) reset 
{
   currentPosition = 0.0; 
}

- (KJKeyFrame *) currentKeyFrame 
{
    if ([keyFrames count] == 0) return nil;
    return [keyFrames objectAtIndex:keyFrameIndex];
}
- (KJKeyFrame *) nextKeyFrame 
{
    if ([keyFrames count] == 0) return nil;
    return [keyFrames objectAtIndex:(keyFrameIndex+1)%[keyFrames count]];
}
- (double) percentThroughCurrentFrame 
{
    double base = currentPosition - [[self currentKeyFrame] timePoint];
    double startOfNext = [[self nextKeyFrame] timePoint] - [[self currentKeyFrame] timePoint];
    
    // check looping/mod condition
    if (startOfNext <= base) {
        startOfNext = duration;
    }
    
    return base/startOfNext;
}
#pragma mark -

@end
