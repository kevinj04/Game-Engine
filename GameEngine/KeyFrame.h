//
//  KeyFrame.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const keyFrameTimePoint;
extern NSString *const keyFrameSpriteFrame;
extern NSString *const keyFrameSpritePosition;
extern NSString *const keyFrameSpriteRotation;
extern NSString *const keyFrameSpriteScaleX;
extern NSString *const keyFrameSpriteScaleY;
extern NSString *const keyFrameFlipX;
extern NSString *const keyFrameFlipY;

@interface KeyFrame : NSObject {
    
    double timePoint;
    
    NSString *frame;
    CGPoint position;
    float rotation;
    float scaleX;
    float scaleY;
    bool flipX;
    bool flipY;
    
}

@property double timePoint;

@property (nonatomic, retain) NSString *frame;
@property CGPoint position;
@property float rotation;
@property float scaleX;
@property float scaleY;
@property bool flipX;
@property bool flipY;

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) frameWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

@end
