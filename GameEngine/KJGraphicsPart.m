//
//  KJGraphicsPart.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJGraphicsPart.h"

NSString *const kjPartAnimations = @"animations";
NSString *const kjPartRunningAnimation = @"runningAnimation";
NSString *const kjPartVertexZ = @"vertexZ";
NSString *const kjPartZOrder = @"zOrder";
NSString *const kjPartAnchorPoint = @"anchorPoint";
NSString *const kjPartIgnoreBoundingBox = @"ignoreBoundingBox";
NSString *const kjPartShouldIgnoreBatchNodeUpdate = @"ignoreBatchNode";

@interface KJGraphicsPart (private)
- (void) tween;
@end

@implementation KJGraphicsPart (private)
- (void) tween {



    KJKeyFrame *currentKF = [self.currentTimeLine currentKeyFrame];
    KJKeyFrame *nextKF = [self.currentTimeLine nextKeyFrame];

    [self setSpriteFrameName:[currentKF frame]];

    [self setFlipX:self.masterFlipX ^ [currentKF flipX]];
    [self setFlipY:self.masterFlipY ^ [currentKF flipY]];

    double percentTween = [self.currentTimeLine percentThroughCurrentFrame];


    // division by 2.0 here only needed if retina/ipad
    double xOffset = ([self.parent anchorPoint].x - 0.5f) * [self.parent boundingBox].size.width/2.0;
    double yOffset = ([self.parent anchorPoint].y - 0.5f) * [self.parent boundingBox].size.height/2.0;
    CGPoint offsetAP = CGPointMake(xOffset, yOffset);

    CGPoint offset = CGPointMake([currentKF position].x +
                                 (([nextKF position].x - [currentKF position].x) * percentTween),
                                 [currentKF position].y +
                                 (([nextKF position].y - [currentKF position].y) * percentTween));
    CGPoint newPosition = CGPointMake(offset.x-offsetAP.x+self.masterPosition.x,
                                      offset.y-offsetAP.y+self.masterPosition.y);
    [self setPosition:newPosition];

    // parent rotation gets confusing?

    float rotationRange = [nextKF rotation] - [currentKF rotation];
    float newRotation = [currentKF rotation] + rotationRange * percentTween;
    [self setRotation:newRotation + self.masterRotation];

    // parent scaling is multiplicative
    // we may not want to scale multiplicatively, as this will be handled by the graphics...
    // Typically we will be scaling the parent and not wanting to scale the children multiplicatively.
    float baseScaleX = 1.0; //[parent scaleX];
    float baseScaleY = 1.0; //[parent scaleY];

    float scaleRangeX = [nextKF scaleX] - [currentKF scaleX];
    float scaleRangeY = [nextKF scaleY] - [currentKF scaleY];

    float newScaleX = self.masterScaleX * baseScaleX * ([currentKF scaleX] + (scaleRangeX * percentTween));
    float newScaleY = self.masterScaleY * baseScaleY * ([currentKF scaleY] + (scaleRangeY * percentTween));
    [self setScaleX:newScaleX];
    [self setScaleY:newScaleY];

    self.zOrder = self.masterZOrder + [self.parent zOrder];
    self.vertexZ = self.masterVertexZ + [self.parent vertexZ];

}
@end

@implementation KJGraphicsPart

@synthesize objectName = _objectName;
@synthesize parent = _parent;
@synthesize currentTimeLine = _currentTimeLine;
@synthesize animations = _animations;
@synthesize spriteRep = _spriteRep;

@synthesize spriteFrameName = _spriteFrameName;
@synthesize position = _position;
@synthesize boundingBox = _boundingBox;
@synthesize rotation = _rotation;
@synthesize scaleX = _scaleX;
@synthesize scaleY = _scaleY;
@synthesize vertexZ = _vertexZ;
@synthesize zOrder = _zOrder;
@synthesize flipX = _flipX;
@synthesize flipY = _flipY;
@synthesize anchorPoint = _anchorPoint;
@synthesize visible = _visible;
@synthesize shouldIgnoreBatchNodeUpdate = _shouldIgnoreBatchNodeUpdate;

@synthesize masterPosition = _mPosition;
@synthesize masterRotation = _mRotation;
@synthesize masterFlipX = _masterFlipX;
@synthesize masterFlipY = _masterFlipY;
@synthesize masterScaleX = _masterScaleX;
@synthesize masterScaleY = _masterScaleY;
@synthesize masterVertexZ = _masterVertexZ;
@synthesize masterZOrder = _masterZOrder;
@synthesize shouldIgnoreBoundingBoxCalculation = _shouldIgnoreBoundingBoxCalculation;

#pragma mark Initialization Methods
- (id) initWithAnimationDictionary:(NSDictionary *) animationDictionary
{

    if (( self = [super init] )) {

        [self setupWithAnimationDictionary:animationDictionary];
        return self;

    }
    return nil;
}
+ (id) partWithAnimationDictionary:(NSDictionary *) animationDictionary
{
    return [[[KJGraphicsPart alloc] initWithAnimationDictionary:animationDictionary] autorelease];
}
- (void) setupWithAnimationDictionary:(NSDictionary *) animationDictionary
{
    self.spriteRep = nil;

    NSDictionary *animationsDictionary = [animationDictionary objectForKey:kjPartAnimations];

    NSMutableDictionary *timeLines = [NSMutableDictionary dictionaryWithCapacity:[animationsDictionary count]];

    for (NSString *timeLineName in [animationsDictionary allKeys]) {

        NSDictionary *timeLineDictionary = [animationsDictionary objectForKey:timeLineName];
        KJTimeLine *tl = [KJTimeLine timeLineWithDictionary:timeLineDictionary];

        [timeLines setObject:tl forKey:timeLineName];

    }

    self.animations = [[NSDictionary alloc] initWithDictionary:timeLines];

    if ([animationDictionary objectForKey:kjPartRunningAnimation] != nil) {
        NSString *runningAnimation = [animationDictionary objectForKey:kjPartRunningAnimation];
        self.currentTimeLine = [timeLines objectForKey:runningAnimation];
        [self.currentTimeLine reset];
    }

    self.shouldIgnoreBoundingBoxCalculation = NO;
    if ([animationDictionary objectForKey:kjPartIgnoreBoundingBox] != nil) {
        self.shouldIgnoreBoundingBoxCalculation = [[animationDictionary objectForKey:kjPartIgnoreBoundingBox] boolValue];
    }

    self.shouldIgnoreBatchNodeUpdate = NO;
    if ([animationDictionary objectForKey:kjPartShouldIgnoreBatchNodeUpdate] != nil) {
        self.shouldIgnoreBatchNodeUpdate = [[animationDictionary objectForKey:kjPartShouldIgnoreBatchNodeUpdate] boolValue];
    }

    // standard values
    self.spriteFrameName = nil;
    self.position = CGPointMake(0.0, 0.0);
    self.boundingBox = CGRectMake(0.0, 0.0, 1.0, 1.0);
    self.rotation = 0.0f;

    self.scaleX = 1.0f;
    self.scaleY = 1.0f;

    self.masterVertexZ = 1.0f;
    self.masterZOrder = 1;

    self.flipX = NO;
    self.flipY = NO;
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.visible = YES;

    // Master values
    self.masterRotation = 0.0;
    self.masterScaleX = 1.0;
    self.masterScaleY = 1.0;

    if ([animationDictionary objectForKey:kjPartVertexZ] != nil) {
        self.masterVertexZ = [[animationDictionary objectForKey:kjPartVertexZ] floatValue];
    } else {
        self.masterVertexZ = 0.0;
    }

    if ([animationDictionary objectForKey:kjPartZOrder] != nil) {
        self.masterZOrder = [[animationDictionary objectForKey:kjPartZOrder] intValue];
    } else {
        self.masterZOrder = 0;
    }

    if ([animationDictionary objectForKey:kjPartAnchorPoint] != nil) {
        self.anchorPoint = CGPointFromString([animationDictionary objectForKey:kjPartAnchorPoint]);
    }

    self.zOrder = self.masterZOrder + [self.parent zOrder];
    self.vertexZ = self.masterVertexZ + [self.parent vertexZ];

    // call tween to boot the image info
    [self tween];

}
- (void) dealloc {

    if (_parent != nil) { [_parent release]; _parent = nil; }
    if (_animations != nil) { [_animations release]; _animations = nil; }
    if (_spriteRep != nil) { [_spriteRep release]; _spriteRep = nil; }
    if (_spriteFrameName != nil) { [_spriteFrameName release]; _spriteFrameName = nil; }

    [super dealloc];
}
#pragma mark -

#pragma mark Tick Method
- (void) update:(double) dt {

    if (self.spriteRep != nil)
    {
        [self.currentTimeLine update:dt];
        [self tween];
        [self.spriteRep updateWithGraphical:self];
    }

}

#pragma mark Animation Methods
- (void) runAnimation:(NSString *) animationName {
    if ([self.animations objectForKey:animationName] != nil) {
        self.currentTimeLine = [self.animations objectForKey:animationName];
    }
}
- (double) animationSpeed {
    return [self.parent animationSpeed];
}

#pragma mark Positioning Methods
- (bool) shouldIgnoreBoundingBox
{
    return _shouldIgnoreBoundingBoxCalculation;
}

- (CGPoint) frameOffset
{
    return [self.spriteRep frameOffset];
}

@end
