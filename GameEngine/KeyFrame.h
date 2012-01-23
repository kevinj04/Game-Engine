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
extern NSString *const keyFrameSpriteScale;

@interface KeyFrame : NSObject {
    
    double timePoint;
    
    NSString *frame;
    CGPoint position;
    float rotation;
    float scale;
    
}

@property double timePoint;

@property (nonatomic, retain) NSString *frame;
@property CGPoint position;
@property float rotation;
@property float scale;

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) frameWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

@end
