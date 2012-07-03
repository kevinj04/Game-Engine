//
//  KJKeyFrame.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJKeyFrame.h"
#import "Universalizer.h"

NSString *const kjKeyFrameTimePoint = @"timePoint";
NSString *const kjKeyFrameSpriteFrame = @"frame";
NSString *const kjKeyFrameSpritePosition = @"position";
NSString *const kjKeyFrameSpriteRotation = @"rotation";
NSString *const kjKeyFrameSpriteScaleX = @"scaleX";
NSString *const kjKeyFrameSpriteScaleY = @"scaleY";
NSString *const kjKeyFrameFlipX = @"flipX";
NSString *const kjKeyFrameFlipY = @"flipY";

@implementation KJKeyFrame

@synthesize frame = _frame;
@synthesize timePoint = _timePoint;
@synthesize position = _position;
@synthesize rotation = _rotation;
@synthesize scaleX = _scaleX;
@synthesize scaleY = _scaleY;
@synthesize flipX = _flipX;
@synthesize flipY = _flipY;

#pragma mark Initialization Methods
- (id) init
{
    self = [super init];
    if (self) [self setup];
    return self;
}
- (id) initWithDictionary:(NSDictionary *) dictionary
{
    self = [super init];
    if (self) [self setupWithDictionary:dictionary];
    return self;
}
+ (id) frameWithDictionary:(NSDictionary *) dictionary
{
   return [[[KJKeyFrame alloc] initWithDictionary:dictionary] autorelease];
}
+ (id) frame
{
    return [[[KJKeyFrame alloc] init] autorelease];
}
- (void) setup
{
    self.timePoint = 0.0;
    self.frame = kjKeyFrameSpriteFrame;
    self.position = CGPointMake(0.0,0.0);
    self.rotation = 0.0;
    self.scaleX = 1.0;
    self.scaleY = 1.0;
    self.flipX = NO;
    self.flipY = NO;
}
- (void) setupWithDictionary:(NSDictionary *) dictionary
{
    if ([dictionary objectForKey:kjKeyFrameTimePoint] != nil) {
        self.timePoint = [[dictionary objectForKey:kjKeyFrameTimePoint] doubleValue];
    }

    if ([dictionary objectForKey:kjKeyFrameSpriteFrame] != nil) {
        self.frame = [[dictionary objectForKey:kjKeyFrameSpriteFrame] retain];
    }

    if ([dictionary objectForKey:kjKeyFrameSpritePosition] != nil) {
        self.position = [Universalizer scalePointForIPad:CGPointFromString([dictionary objectForKey:kjKeyFrameSpritePosition])];
    }

    if ([dictionary objectForKey:kjKeyFrameSpriteRotation] != nil) {
        self.rotation = [[dictionary objectForKey:kjKeyFrameSpriteRotation] floatValue];
    }

    if ([dictionary objectForKey:kjKeyFrameSpriteScaleX] != nil) {
        self.scaleX = [[dictionary objectForKey:kjKeyFrameSpriteScaleY] floatValue];
    }

    if ([dictionary objectForKey:kjKeyFrameSpriteScaleY] != nil) {
        self.scaleY = [[dictionary objectForKey:kjKeyFrameSpriteScaleY] floatValue];
    }

    if ([dictionary objectForKey:kjKeyFrameFlipX] != nil) {
        self.flipX = [[dictionary objectForKey:kjKeyFrameFlipX] boolValue];
    }

    if ([dictionary objectForKey:kjKeyFrameFlipY] != nil) {
        self.flipY = [[dictionary objectForKey:kjKeyFrameFlipY] boolValue];
    }
}
- (void) dealloc
{
    if (_frame != nil) { [_frame release]; _frame = nil; }
    [super dealloc];
}

@end
