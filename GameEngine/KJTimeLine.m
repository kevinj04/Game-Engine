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

    if ([self.keyFrames count] == 1) {
        self.keyFrameIndex = 0;
        return; // avoids a loop below if we only have one keyframe
    }

    while (self.currentPosition > [[self nextKeyFrame] timePoint]) {
        self.keyFrameIndex = (self.keyFrameIndex + 1) % [self.keyFrames count];

        if (self.keyFrameIndex == 0 & [self.keyFrames count] > 1) {
            self.currentPosition -= self.duration;
        }
    }

}
@end

@implementation KJTimeLine

@synthesize keyFrames = _keyFrames;
@synthesize currentPosition = _currentPosition;
@synthesize duration = _duration;
@synthesize keyFrameIndex = _keyFrameIndex;

#pragma mark Initialization Methods
- (id) init
{
    self = [super init];
    if (self) [self setup];
    return self;
}
+ (id) timeLine
{
    return [[[KJTimeLine alloc] init] autorelease];
}
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
- (void) setup
{
    self.keyFrames = [[NSArray alloc] init];
    self.currentPosition = 0.0;
    self.duration = 1.0;
    self.keyFrameIndex = 0;
}
- (void) setupWithDictionary:(NSDictionary *) dictionary
{
    [self setup];

    if ([dictionary objectForKey:kjTimeLineCurrentPosition] != nil) {
        self.currentPosition = [[dictionary objectForKey:kjTimeLineCurrentPosition] floatValue];
    }

    if ([dictionary objectForKey:kjTimeLineDuration] != nil) {
        self.duration = [[dictionary objectForKey:kjTimeLineDuration] floatValue];
    }

    if ([dictionary objectForKey:kjTimeLineKeyFrames] != nil) {

        [self.keyFrames release];
        self.keyFrames = nil;

        NSArray *arr = [dictionary objectForKey:kjTimeLineKeyFrames];

        NSMutableArray *tempFrames = [NSMutableArray arrayWithCapacity:[arr count]];

        for (NSDictionary *d in arr) {

            KJKeyFrame *frame = [KJKeyFrame frameWithDictionary:d];
            [tempFrames addObject:frame];

        }

        self.keyFrames = [[NSArray alloc] initWithArray:tempFrames];

    }
    
    [self updateKeyFrames];

}
- (void) dealloc
{
    if (_keyFrames != nil) { [_keyFrames release]; _keyFrames = nil; }
    [super dealloc];
}

#pragma mark Tick Method
- (void) update:(double) dt
{
    self.currentPosition += dt;
    [self updateKeyFrames];
}

#pragma mark Helper Methods
- (void) reset
{
   self.currentPosition = 0.0;
}

- (KJKeyFrame *) currentKeyFrame
{
    if ([self.keyFrames count] == 0) return nil;
    return [self.keyFrames objectAtIndex:self.keyFrameIndex];
}
- (KJKeyFrame *) nextKeyFrame
{
    if ([self.keyFrames count] == 0) return nil;
    return [self.keyFrames objectAtIndex:(self.keyFrameIndex+1)%self.keyFrames.count];
}
- (double) percentThroughCurrentFrame
{
    double base = self.currentPosition - [[self currentKeyFrame] timePoint];
    double startOfNext = [[self nextKeyFrame] timePoint] - [[self currentKeyFrame] timePoint];

    // check looping/mod condition
    if (startOfNext <= base) {
        startOfNext = self.duration;
    }

    return base/startOfNext;
}

@end
