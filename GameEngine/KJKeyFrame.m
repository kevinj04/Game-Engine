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

@synthesize timePoint, frame, position, rotation, scaleX, scaleY, flipX, flipY;

#pragma mark -
#pragma mark Initialization Methods
- (id) initWithDictionary:(NSDictionary *) dictionary 
{
    if (( self = [super init] )) 
    {
        
        [self setupWithDictionary:dictionary];
        return self;
        
    } else {
        return nil;
    }
}
+ (id) frameWithDictionary:(NSDictionary *) dictionary 
{
   return [[[KJKeyFrame alloc] initWithDictionary:dictionary] autorelease]; 
}
- (void) setupWithDictionary:(NSDictionary *) dictionary 
{
    timePoint = 0.0;
    frame = kjKeyFrameSpriteFrame;
    position = CGPointMake(0.0,0.0);
    rotation = 0.0;
    scaleX = 1.0;    
    scaleY = 1.0;
    flipX = NO;
    flipY = NO;
    
    if ([dictionary objectForKey:kjKeyFrameTimePoint] != nil) {
        timePoint = [[dictionary objectForKey:kjKeyFrameTimePoint] doubleValue];
    }
    
    if ([dictionary objectForKey:kjKeyFrameSpriteFrame] != nil) {
        frame = [[dictionary objectForKey:kjKeyFrameSpriteFrame] retain];
    }
    
    if ([dictionary objectForKey:kjKeyFrameSpritePosition] != nil) {
        position = [Universalizer scalePointForIPad:CGPointFromString([dictionary objectForKey:kjKeyFrameSpritePosition])];
    }
    
    if ([dictionary objectForKey:kjKeyFrameSpriteRotation] != nil) {
        rotation = [[dictionary objectForKey:kjKeyFrameSpriteRotation] floatValue];
    }
    
    if ([dictionary objectForKey:kjKeyFrameSpriteScaleX] != nil) {
        scaleX = [[dictionary objectForKey:kjKeyFrameSpriteScaleY] floatValue];
    }
    
    if ([dictionary objectForKey:kjKeyFrameSpriteScaleY] != nil) {
        scaleY = [[dictionary objectForKey:kjKeyFrameSpriteScaleY] floatValue];
    }
    
    if ([dictionary objectForKey:kjKeyFrameFlipX] != nil) {
        flipX = [[dictionary objectForKey:kjKeyFrameFlipX] boolValue];
    }
    
    if ([dictionary objectForKey:kjKeyFrameFlipY] != nil) {
        flipY = [[dictionary objectForKey:kjKeyFrameFlipY] boolValue];
    }
}
- (void) dealloc 
{
    if (frame != nil) { [frame release]; frame = nil; }
    [super dealloc];
}
#pragma mark -


@end
