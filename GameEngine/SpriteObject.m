//
//  SpritePart.m
//  GameEngine
//
//  Created by Kevin Jenkins on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpritePart.h"

@interface SpritePart (private)
- (void) tween;
@end

@implementation SpritePart (private)
- (void) tween {
    
    KeyFrame *currentKF = [currentTimeLine currentKeyFrame];
    KeyFrame *nextKF = [currentTimeLine nextKeyFrame];
    
    //[spriteRep setSpriteFrame:[currentKF frame]];
    [self setSpriteFrameName:[currentKF frame]];
    
    /*
     [spriteRep setFlipX:[currentKF flipX]];
     [spriteRep setFlipY:[currentKF flipY]];
     */
    
    [self setFlipX:m_flipX ^ [currentKF flipX]];
    [self setFlipY:m_flipY ^ [currentKF flipY]];
    
    double percentTween = [currentTimeLine percentThroughCurrentFrame];
    
    // remove if fail
    // we assume that the parent is a container object?
    
    // division by 2.0 here only needed if retina/ipad
    double xOffset = ([parent anchorPoint].x - 0.5f) * [parent boundingBox].size.width/2.0;
    double yOffset = ([parent anchorPoint].y - 0.5f) * [parent boundingBox].size.height/2.0;
    CGPoint offsetAP = CGPointMake(xOffset, yOffset);
    
    CGPoint offset = CGPointMake([currentKF position].x + 
                                 (([nextKF position].x - [currentKF position].x) * percentTween), 
                                 [currentKF position].y + 
                                 (([nextKF position].y - [currentKF position].y) * percentTween));
    CGPoint newPosition = CGPointMake(offset.x-offsetAP.x+m_position.x,
                                      offset.y-offsetAP.y+m_position.y);
    [self setPosition:newPosition];    
    
    // parent rotation gets confusing?
    
    float rotationRange = [nextKF rotation] - [currentKF rotation];
    float newRotation = [currentKF rotation] + rotationRange * percentTween;
    [self setRotation:newRotation + m_rotation];
    
    // parent scaling is multiplicative
    // we may not want to scale multiplicatively, as this will be handled by the graphics...
    // Typically we will be scaling the parent and not wanting to scale the children exponentially.
    float baseScaleX = 1.0; //[parent scaleX];
    float baseScaleY = 1.0; //[parent scaleY];
    
    float scaleRangeX = [nextKF scaleX] - [currentKF scaleX];
    float scaleRangeY = [nextKF scaleY] - [currentKF scaleY];
    
    float newScaleX = baseScaleX * ([currentKF scaleX] + (scaleRangeX * percentTween));
    float newScaleY = baseScaleY * ([currentKF scaleY] + (scaleRangeY * percentTween));
    [self setScaleX:newScaleX];
    [self setScaleY:newScaleY];
    
}
@end

@implementation SpritePart

@synthesize name;
@synthesize spriteFrameName, position, rotation, scaleX, scaleY, vertexZ, zOrder, flipX, flipY, anchorPoint, boundingBox, visible;

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
    
    // standard values
    spriteFrameName = nil;    
    position = CGPointMake(0.0, 0.0);
    boundingBox = CGRectMake(0.0, 0.0, 1.0, 1.0);
    rotation = 0.0f;
    
    scaleX = 1.0f;
    scaleY = 1.0f;
    
    vertexZ = 1.0f;
    zOrder = 1;
    
    flipX = NO;
    flipY = NO;
    anchorPoint = CGPointMake(0.5, 0.5);
    visible = YES;
    
    // Master values
    m_rotation = 0.0;
    
    if ([dictionary objectForKey:partVertexZ] != nil) {        
        vertexZ = [[dictionary objectForKey:partVertexZ] floatValue];        
    } else {
        vertexZ = 0.0;
    }
    
    if ([dictionary objectForKey:partZOrder] != nil) {        
        zOrder = [[dictionary objectForKey:partZOrder] intValue];        
    } else {
        zOrder = 0;
    }
    
    if ([dictionary objectForKey:partAnchorPoint] != nil) {
        anchorPoint = CGPointFromString([dictionary objectForKey:partAnchorPoint]);
    }
    
    // call tween to boot the image info
    [self tween];
    
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

- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *) updateObj {
    [spriteRep updateWithPhysicsInfo:self]; // changed? // CHECK THIS
}

- (void) runAnimation:(NSString *) animationName {
    if ([animations objectForKey:animationName] != nil) {
        currentTimeLine = [animations objectForKey:animationName];
    }
}

- (void) setMasterPosition:(CGPoint) p {
    m_position = p;
}
- (void) setMasterRotation:(float) r {
    m_rotation = r;
}
- (void) setMasterFlipX:(bool)b {
    m_flipX = b;
}
- (void) setMasterFlipY:(bool)b {
    m_flipY = b;
}

- (void) setParent:(SpriteObject *) spriteObj {
    parent = [spriteObj retain];
    [spriteRep updateWithPhysicsInfo:self];
}

- (void) setSpriteRep:(NSObject<GraphicsProtocol> *) rep {
    spriteRep = [rep retain];
}
- (NSObject<GraphicsProtocol> *) spriteRep {
    return spriteRep;
}
- (CGPoint) frameOffset {
    return [spriteRep frameOffset];
}

@end
