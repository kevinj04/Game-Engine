//
//  TimeLine.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyFrame.h"

/**
 
 The TimeLine is a representation of a series of KeyFrames for animation. The duration dictates the length in seconds of the animation loop, and the currentPosition indicates where in the loop the current animation resides.
 
 */

extern NSString *const timeLineKeyFrames;
extern NSString *const timeLineCurrentPosition;
extern NSString *const timeLineDuration;

@interface TimeLine : NSObject {
    
    @private
    NSArray *keyFrames;
    double currentPosition;
    double duration;
    
    int keyFrameIndex;
    
}

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) timeLineWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

- (void) update:(double) dt;
- (void) reset;

- (KeyFrame *) currentKeyFrame;
- (KeyFrame *) nextKeyFrame;
- (float) percentThroughCurrentFrame;

@end
