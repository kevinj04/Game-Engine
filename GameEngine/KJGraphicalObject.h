//
//  KJGraphicalObject.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJPhysicsObject.h"
#import "KJGraphical.h"

extern NSString *const kjObjectParts;
extern NSString *const kjObjectAnimations;
extern NSString *const kjObjectRunningAnimation;
extern NSString *const kjVertexZ;
extern NSString *const kjZOrder;
extern NSString *const kjPrimaryPart;
extern NSString *const kjShouldIgnoreBatchNodeUpdate;
extern NSString *const kjAnimationRequest;
extern NSString *const kjTargetPart;

@interface KJGraphicalObject : KJPhysicsObject<KJGraphical>
{

}

@property (nonatomic, assign) float scaleX;
@property (nonatomic, assign) float scaleY;
@property (nonatomic, assign) float vertexZ;
@property (nonatomic, assign) int zOrder;
@property (nonatomic, assign) bool visible;
@property (nonatomic, assign) bool flipX;
@property (nonatomic, assign) bool flipY;
@property (nonatomic, assign) bool shouldIgnoreBatchNodeUpdate;
@property (nonatomic, assign) double animationSpeed;
@property (nonatomic, retain) NSDictionary *parts;
@property (nonatomic, retain) NSString *primaryPart;

- (void) setupGraphicsWithDictionary:(NSDictionary *) animationDictionary;

- (void) handleAnimationNotification:(NSNotification *) notification;

- (void) runAnimation:(NSString *) animationName onPart:(NSString *) partName;
- (void) runAnimation:(NSString *) animationName;

- (void) setPosition:(CGPoint) p forPart:(NSString *) partName;
- (void) setRotation:(float) r forPart:(NSString *) partName;
- (void) setFlipX:(bool) b forPart:(NSString *) partName;
- (void) setFlipY:(bool) b forPart:(NSString *) partName;
- (void) setScaleX:(float) f forPart:(NSString *) partName;
- (void) setScaleY:(float) f forPart:(NSString *) partName;

- (void) setScaleX:(float) sx;
- (void) setScaleY:(float) sy;

- (CGPoint) primaryPartOffset;

- (void) detachParts;

@end
