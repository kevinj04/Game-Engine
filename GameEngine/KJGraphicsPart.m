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
    

    
    KJKeyFrame *currentKF = [currentTimeLine currentKeyFrame];
    KJKeyFrame *nextKF = [currentTimeLine nextKeyFrame];
    
    [self setSpriteFrameName:[currentKF frame]];
    
    [self setFlipX:mFlipX ^ [currentKF flipX]];
    [self setFlipY:mFlipY ^ [currentKF flipY]];
    
    double percentTween = [currentTimeLine percentThroughCurrentFrame];
    
    
    // division by 2.0 here only needed if retina/ipad
    double xOffset = ([parent anchorPoint].x - 0.5f) * [parent boundingBox].size.width/2.0;
    double yOffset = ([parent anchorPoint].y - 0.5f) * [parent boundingBox].size.height/2.0;
    CGPoint offsetAP = CGPointMake(xOffset, yOffset);
    
    CGPoint offset = CGPointMake([currentKF position].x + 
                                 (([nextKF position].x - [currentKF position].x) * percentTween), 
                                 [currentKF position].y + 
                                 (([nextKF position].y - [currentKF position].y) * percentTween));
    CGPoint newPosition = CGPointMake(offset.x-offsetAP.x+mPosition.x,
                                      offset.y-offsetAP.y+mPosition.y);
    [self setPosition:newPosition];    
    
    // parent rotation gets confusing?
    
    float rotationRange = [nextKF rotation] - [currentKF rotation];
    float newRotation = [currentKF rotation] + rotationRange * percentTween;
    [self setRotation:newRotation + mRotation];
    
    // parent scaling is multiplicative
    // we may not want to scale multiplicatively, as this will be handled by the graphics...
    // Typically we will be scaling the parent and not wanting to scale the children multiplicatively.
    float baseScaleX = 1.0; //[parent scaleX];
    float baseScaleY = 1.0; //[parent scaleY];
    
    float scaleRangeX = [nextKF scaleX] - [currentKF scaleX];
    float scaleRangeY = [nextKF scaleY] - [currentKF scaleY];
    
    float newScaleX = mScaleX * baseScaleX * ([currentKF scaleX] + (scaleRangeX * percentTween));
    float newScaleY = mScaleY * baseScaleY * ([currentKF scaleY] + (scaleRangeY * percentTween));
    [self setScaleX:newScaleX];
    [self setScaleY:newScaleY];
    
    zOrder = mZOrder + [parent zOrder];
    vertexZ = mVertexZ + [parent vertexZ];
    
}
@end

@implementation KJGraphicsPart

@synthesize objectName;
@synthesize spriteFrameName, position, rotation, scaleX, scaleY, vertexZ, zOrder, flipX, flipY, anchorPoint, boundingBox, visible, shouldIgnoreBatchNodeUpdate;

#pragma mark -
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
    spriteRep = nil;
    
    NSDictionary *animationsDictionary = [animationDictionary objectForKey:kjPartAnimations];
    
    NSMutableDictionary *timeLines = [NSMutableDictionary dictionaryWithCapacity:[animationsDictionary count]];
    
    for (NSString *timeLineName in [animationsDictionary allKeys]) {
        
        NSDictionary *timeLineDictionary = [animationsDictionary objectForKey:timeLineName];
        KJTimeLine *tl = [KJTimeLine timeLineWithDictionary:timeLineDictionary];
        
        [timeLines setObject:tl forKey:timeLineName];
        
    }
    
    animations = [[NSDictionary alloc] initWithDictionary:timeLines];
    
    if ([animationDictionary objectForKey:kjPartRunningAnimation] != nil) {
        NSString *runningAnimation = [animationDictionary objectForKey:kjPartRunningAnimation];
        currentTimeLine = [timeLines objectForKey:runningAnimation];
        [currentTimeLine reset];
    }
    
    shouldIgnoreBoundingBoxCalculation = NO;
    if ([animationDictionary objectForKey:kjPartIgnoreBoundingBox] != nil) {
        shouldIgnoreBoundingBoxCalculation = [[animationDictionary objectForKey:kjPartIgnoreBoundingBox] boolValue];
    }
    
    shouldIgnoreBatchNodeUpdate = NO;
    if ([animationDictionary objectForKey:kjPartShouldIgnoreBatchNodeUpdate] != nil) {
        shouldIgnoreBatchNodeUpdate = [[animationDictionary objectForKey:kjPartShouldIgnoreBatchNodeUpdate] boolValue];
    }
    
    // standard values
    spriteFrameName = nil;    
    position = CGPointMake(0.0, 0.0);
    boundingBox = CGRectMake(0.0, 0.0, 1.0, 1.0);
    rotation = 0.0f;
    
    scaleX = 1.0f;
    scaleY = 1.0f;
    
    mVertexZ = 1.0f;
    mZOrder = 1;
    
    flipX = NO;
    flipY = NO;
    anchorPoint = CGPointMake(0.5, 0.5);
    visible = YES;
    
    // Master values
    mRotation = 0.0;
    mScaleX = 1.0;
    mScaleY = 1.0;
    
    if ([animationDictionary objectForKey:kjPartVertexZ] != nil) {        
        mVertexZ = [[animationDictionary objectForKey:kjPartVertexZ] floatValue];        
    } else {
        mVertexZ = 0.0;
    }
    
    if ([animationDictionary objectForKey:kjPartZOrder] != nil) {        
        mZOrder = [[animationDictionary objectForKey:kjPartZOrder] intValue];        
    } else {
        mZOrder = 0;
    }
    
    if ([animationDictionary objectForKey:kjPartAnchorPoint] != nil) {
        anchorPoint = CGPointFromString([animationDictionary objectForKey:kjPartAnchorPoint]);
    }
    
    zOrder = mZOrder + [parent zOrder];
    vertexZ = mVertexZ + [parent vertexZ];
    
    // call tween to boot the image info
    [self tween];
    
}
- (void) dealloc {
    
    if (parent != nil) { [parent release]; parent = nil; }
    if (animations != nil) { [animations release]; animations = nil; }
    if (spriteRep != nil) { [spriteRep release]; spriteRep = nil; }
    if (spriteFrameName != nil) { [spriteFrameName release]; spriteFrameName = nil; }
    
    [super dealloc];
}
#pragma mark -

#pragma mark Tick Method
- (void) update:(double) dt {
    
    if (spriteRep != nil) 
    {
        [currentTimeLine update:dt];
        [self tween];
        [spriteRep updateWithGraphical:self];
    }
        
}
#pragma mark -

#pragma mark Animation Methods
- (void) runAnimation:(NSString *) animationName {
    if ([animations objectForKey:animationName] != nil) {
        currentTimeLine = [animations objectForKey:animationName];
    }
}
- (double) animationSpeed {
    return [parent animationSpeed];
}
#pragma mark -

#pragma mark Master Modifiers
- (void) setMasterPosition:(CGPoint) p {
    mPosition = p;
}
- (void) setMasterRotation:(float) r {
    mRotation = r;
}
- (void) setMasterFlipX:(bool) b {
    mFlipX = b;
}
- (void) setMasterFlipY:(bool) b {
    mFlipY = b;
}
- (void) setMasterScaleX:(float) f {
    mScaleX = f;
}
- (void) setMasterScaleY:(float) f {
    mScaleY = f; 
}
#pragma mark -


#pragma mark Setters and Getters
- (void) setParent:(KJGraphicalObject *) graphicalObject 
{
    if (parent != nil) { [parent release]; parent = nil; }
    if (graphicalObject == nil) return;
    parent = [graphicalObject retain];
}
- (KJGraphicalObject *) parent 
{
    return parent;
}
- (void) setSpriteRep:(NSObject<KJGraphicalRepresentationProtocol> *) rep
{
    spriteRep = [rep retain];
}
- (NSObject<KJGraphicalRepresentationProtocol> *) graphicalRepresentation 
{
    return spriteRep;
}
#pragma mark -


#pragma mark Positioning Methods
- (bool) shouldIgnoreBoundingBox 
{    
    return shouldIgnoreBoundingBoxCalculation;
}

- (CGPoint) frameOffset 
{
    return [spriteRep frameOffset];
}
#pragma mark -

@end
