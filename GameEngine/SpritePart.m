//
//  SpritePart.m
//  GameEngine
//
//  Created by Kevin Jenkins on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpritePart.h"

NSString *const partAnimations = @"animations";
NSString *const partRunningAnimation = @"runningAnimation";

@interface SpritePart (private)
- (void) tween;
@end

@implementation SpritePart (private)
- (void) tween {
    
    KeyFrame *currentKF = [currentTimeLine currentKeyFrame];
    KeyFrame *nextKF = [currentTimeLine nextKeyFrame];
    
    [spriteRep setSpriteFrame:[currentKF frame]];
    
    double percentTween = [currentTimeLine percentThroughCurrentFrame];
    
    CGPoint base = [parent childBasePosition];
    
    CGPoint offset = CGPointMake([currentKF position].x + 
                                    (([nextKF position].x - [currentKF position].x) * percentTween), 
                                 [currentKF position].y + 
                                    (([nextKF position].y - [currentKF position].y) * percentTween));
    [spriteRep setPosition:CGPointMake(base.x+offset.x,
                                       base.y+offset.y)];
    
    // parent rotation gets confusing?
    
    float rotationRange = [nextKF rotation] - [currentKF rotation];
    [spriteRep setRotation:[currentKF rotation] + rotationRange * percentTween];
    
    // parent scaling is multiplicative
    float baseScale = [parent scale];
    
    float scaleRange = [nextKF scale] - [currentKF scale];
    [spriteRep setScale:baseScale * ([currentKF scale] + (scaleRange * percentTween))];
    
}
@end

@implementation SpritePart

@synthesize name;

- (id) initWithDictionary:(NSDictionary *) dictionary {
    
    if (( self = [super init] )) {
        
        [self setupWithDictionary:dictionary];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) partWithDictionary:(NSDictionary *) dictionary {
    return [[[SpritePart alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    spriteRep = nil;
 
    NSDictionary *animationsDictionary = [dictionary objectForKey:partAnimations];
    
    NSMutableDictionary *timeLines = [NSMutableDictionary dictionaryWithCapacity:[animationsDictionary count]];
    
    for (NSString *timeLineName in [animationsDictionary allKeys]) {
        
        NSDictionary *timeLineDictionary = [animationsDictionary objectForKey:timeLineName];
        TimeLine *tl = [TimeLine timeLineWithDictionary:timeLineDictionary];
        
        [timeLines setObject:tl forKey:timeLineName];
        
    }
    
    animations = [[NSDictionary alloc] initWithDictionary:timeLines];
    
    if ([dictionary objectForKey:partRunningAnimation] != nil) {
        NSString *runningAnimation = [dictionary objectForKey:partRunningAnimation];
        currentTimeLine = [timeLines objectForKey:runningAnimation];
        [currentTimeLine reset];
    }
    
}
- (void) dealloc {
    
    if (name != nil) { [name release]; name = nil; }
    if (animations != nil) { [animations release]; animations = nil; }
    if (currentTimeLine != nil) { [currentTimeLine release]; currentTimeLine = nil; }
    
    [super dealloc];
}

- (void) update:(double) dt {
    
    [currentTimeLine update:dt];
    
    if (spriteRep != nil) {
        [self tween];
    }
    
}
- (void) runAnimation:(NSString *) animationName {
    if ([animations objectForKey:animationName] != nil) {
        currentTimeLine = [animations objectForKey:animationName];
    }
}

- (void) setParent:(SpriteObject *) spriteObj {
    parent = [spriteObj retain];
}
- (void) setSpriteRep:(NSObject<GraphicsProtocol> *) rep {
    spriteRep = [rep retain];
}
- (NSObject<GraphicsProtocol> *) spriteRep {
    return spriteRep;
}

@end
