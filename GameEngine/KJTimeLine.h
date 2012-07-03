//
//  KJTimeLine.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJKeyFrame.h"

extern NSString *const kjTimeLineKeyFrames;
extern NSString *const kjTimeLineCurrentPosition;
extern NSString *const kjTimeLineDuration;

@interface KJTimeLine : NSObject {

}

@property (nonatomic, retain) NSArray *keyFrames;
@property (nonatomic, assign) double currentPosition;
@property (nonatomic, assign) double duration;
@property (nonatomic, assign) int keyFrameIndex;

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) timeLineWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

- (void) update:(double) dt;
- (void) reset;

- (KJKeyFrame *) currentKeyFrame;
- (KJKeyFrame *) nextKeyFrame;
- (double) percentThroughCurrentFrame;


@end
