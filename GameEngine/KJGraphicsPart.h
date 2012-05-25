//
//  KJGraphicsPart.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimeLine.h"
#import "KJGraphical.h"
#import "KJGraphicalRepresentationProtocol.h"

extern NSString *const kjPartAnimations;
extern NSString *const kjPartRunningAnimation;
extern NSString *const kjPartVertexZ;
extern NSString *const kjPartZOrder;
extern NSString *const kjPartAnchorPoint;
extern NSString *const kjPartIgnoreBoundingBox;
extern NSString *const kjPartShouldIgnoreBatchNodeUpdate;

@class KJGraphicalObject;

@interface KJGraphicsPart : NSObject<KJGraphical> {
    
    NSString *objectName;
    KJGraphicalObject *parent;
    
    TimeLine *currentTimeLine;
    NSDictionary *animations;
    
    NSObject<KJGraphicalRepresentationProtocol> *spriteRep;
    
    /** Sprite Info  -- Read by sprites, modified by key frames tweening */
    
    // Perhaps this could really be a physicsObject?
    
    NSString *spriteFrameName;    
    CGPoint position;
    CGRect boundingBox;
    float rotation;
    
    float scaleX;
    float scaleY;
    
    float vertexZ;
    int zOrder;
    
    bool flipX;
    bool flipY;
    CGPoint anchorPoint;
    bool visible;
    
    bool shouldIgnoreBatchNodeUpdate;
    
    /** Master Part Properties: Modified by SpriteObject, adjusts the part itself.
     Incorporated into SpriteInfo above during tween. We may add more properties here.**/
    CGPoint mPosition;
    float mRotation;
    bool mFlipX;
    bool mFlipY;
    
    float mScaleX;
    float mScaleY;
    
    float mVertexZ;
    int mZOrder;
    
    bool shouldIgnoreBoundingBoxCalculation;
}

@property (nonatomic, retain) NSString *objectName;

/** Sprite Representation Information **/

@property (nonatomic, retain) NSString *spriteFrameName;    
@property CGPoint position;
@property float rotation;
@property CGRect boundingBox;

@property float scaleX;
@property float scaleY;

@property float vertexZ;
@property int zOrder;

@property bool flipX;
@property bool flipY;
@property CGPoint anchorPoint;
@property bool visible;

@property bool shouldIgnoreBatchNodeUpdate;

/** ------------------- **/

- (id) initWithAnimationDictionary:(NSDictionary *) animationDictionary;
+ (id) partWithAnimationDictionary:(NSDictionary *) animationDictionary;
- (void) setupWithAnimationDictionary:(NSDictionary *) animationDictionary;
- (void) dealloc;

- (void) update:(double) dt;

- (void) runAnimation:(NSString *) animationName;

- (void) setMasterPosition:(CGPoint) p;
- (void) setMasterRotation:(float) r;
- (void) setMasterFlipX:(bool) b;
- (void) setMasterFlipY:(bool) b;
- (void) setMasterScaleX:(float) f;
- (void) setMasterScaleY:(float) f;

- (void) setParent:(KJGraphicalObject *) graphicalObject;
- (KJGraphicalObject *) parent;
- (void) setSpriteRep:(NSObject<KJGraphicalRepresentationProtocol> *) rep;
- (NSObject<KJGraphicalRepresentationProtocol> *) graphicalRepresentation;

- (bool) shouldIgnoreBoundingBox;

- (CGPoint) frameOffset;

@end
