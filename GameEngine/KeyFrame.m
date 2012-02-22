//
//  KeyFrame.m
//  GameEngine
//
//  Created by Kevin Jenkins on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KeyFrame.h"

NSString *const keyFrameTimePoint = @"timePoint";
NSString *const keyFrameSpriteFrame = @"frame";
NSString *const keyFrameSpritePosition = @"position";
NSString *const keyFrameSpriteRotation = @"rotation";
NSString *const keyFrameSpriteScale = @"scale";
NSString *const keyFrameFlipX = @"flipX";
NSString *const keyFrameFlipY = @"flipY";

@implementation KeyFrame

@synthesize timePoint, frame, position, rotation, scale, flipX, flipY;

- (id) initWithDictionary:(NSDictionary *) dictionary {
    
    if (( self = [super init] )) {
        
        [self setupWithDictionary:dictionary];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) frameWithDictionary:(NSDictionary *) dictionary {
    return [[[KeyFrame alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    timePoint = 0.0;
    frame = keyFrameSpriteFrame;
    position = CGPointMake(0.0,0.0);
    rotation = 0.0;
    scale = 1.0;    
    flipX = NO;
    flipY = NO;
    
    if ([dictionary objectForKey:keyFrameTimePoint] != nil) {
        timePoint = [[dictionary objectForKey:keyFrameTimePoint] doubleValue];
    }
    
    if ([dictionary objectForKey:keyFrameSpriteFrame] != nil) {
        frame = [[dictionary objectForKey:keyFrameSpriteFrame] retain];
    }
    
    if ([dictionary objectForKey:keyFrameSpritePosition] != nil) {
        position = CGPointFromString([dictionary objectForKey:keyFrameSpritePosition]);
    }
    
    if ([dictionary objectForKey:keyFrameSpriteRotation] != nil) {
        rotation = [[dictionary objectForKey:keyFrameSpriteRotation] floatValue];
    }
    
    if ([dictionary objectForKey:keyFrameSpriteScale] != nil) {
        scale = [[dictionary objectForKey:keyFrameSpriteScale] floatValue];
    }
    
    if ([dictionary objectForKey:keyFrameFlipX] != nil) {
        flipX = [[dictionary objectForKey:keyFrameFlipX] boolValue];
    }
    
    if ([dictionary objectForKey:keyFrameFlipY] != nil) {
        flipY = [[dictionary objectForKey:keyFrameFlipY] boolValue];
    }
}
- (void) dealloc {
    if (frame != nil) { [frame release]; frame = nil; }
    [super dealloc];
}

@end
