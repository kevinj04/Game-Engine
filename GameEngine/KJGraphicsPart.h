//
//  KJGraphicsPart.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJTimeLine.h"
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

}

@property (nonatomic, retain) NSString *objectName;
@property (nonatomic, retain) KJGraphicalObject *parent;
@property (nonatomic, retain) KJTimeLine *currentTimeLine;
@property (nonatomic, retain) NSDictionary *animations;
@property (nonatomic, retain) NSObject<KJGraphicalRepresentationProtocol> *spriteRep;

// Current Graphic State -- extract?
@property (nonatomic, retain) NSString *spriteFrameName;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGRect boundingBox;
@property (nonatomic, assign) float rotation;
@property (nonatomic, assign) float scaleX;
@property (nonatomic, assign) float scaleY;
@property (nonatomic, assign) float vertexZ;
@property (nonatomic, assign) int zOrder;
@property (nonatomic, assign) bool flipX;
@property (nonatomic, assign) bool flipY;
@property (nonatomic, assign) CGPoint anchorPoint;
@property (nonatomic, assign) bool visible;
@property (nonatomic, assign) bool shouldIgnoreBatchNodeUpdate;

/** Master Part Properties: Modified by SpriteObject, adjusts the part itself.
 Incorporated into SpriteInfo above during tween. We may add more properties here.**/
@property (nonatomic, assign) CGPoint masterPosition;
@property (nonatomic, assign) float masterRotation;
@property (nonatomic, assign) bool masterFlipX;
@property (nonatomic, assign) bool masterFlipY;
@property (nonatomic, assign) float masterScaleX;
@property (nonatomic, assign) float masterScaleY;
@property (nonatomic, assign) float masterVertexZ;
@property (nonatomic, assign) int masterZOrder;
@property (nonatomic, assign) bool shouldIgnoreBoundingBoxCalculation;

- (id) initWithAnimationDictionary:(NSDictionary *) animationDictionary;
+ (id) partWithAnimationDictionary:(NSDictionary *) animationDictionary;
- (void) setupWithAnimationDictionary:(NSDictionary *) animationDictionary;
- (void) dealloc;
- (void) update:(double) dt;
- (void) runAnimation:(NSString *) animationName;
- (CGPoint) frameOffset;

@end
