//
//  KJKeyFrame.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const kjKeyFrameTimePoint;
extern NSString *const kjKeyFrameSpriteFrame;
extern NSString *const kjKeyFrameSpritePosition;
extern NSString *const kjKeyFrameSpriteRotation;
extern NSString *const kjKeyFrameSpriteScaleX;
extern NSString *const kjKeyFrameSpriteScaleY;
extern NSString *const kjKeyFrameFlipX;
extern NSString *const kjKeyFrameFlipY;

@interface KJKeyFrame : NSObject {

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
