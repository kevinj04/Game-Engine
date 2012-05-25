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
    
    float scaleX;
    float scaleY;
    
    float vertexZ;
    int zOrder;
    
    bool visible;
    
    bool flipX;
    bool flipY;
    
    bool shouldIgnoreBatchNodeUpdate; // maybe this is handled in a subclass
    
    double animationSpeed;
    
    NSDictionary *parts;
    NSString *primaryPart;
    
}

@property float scaleX;
@property float scaleY;
@property float vertexZ;
@property int zOrder;

@property bool visible;
@property bool flipX;
@property bool flipY;
@property bool shouldIgnoreBatchNodeUpdate;

@property double animationSpeed;

@property (nonatomic, retain) NSDictionary *parts;
@property (nonatomic, retain) NSString *primaryPart;


- (void) setupGraphicsWithDictionary:(NSDictionary *) animationDictionary;

- (void) handleAnimationNotification:(NSNotification *) notification;

- (void) runAnimation:(NSString *) animationName onPart:(NSString *) partName;
- (void) runAnimation:(NSString *) animationName;

- (void) setPosition:(CGPoint) p forPart:(NSString *) partName;
- (void) setRotation:(float)r forPart:(NSString *) partName;
- (void) setFlipX:(_Bool) b forPart:(NSString *) partName;
- (void) setFlipY:(_Bool) b forPart:(NSString *) partName;
- (void) setScaleX:(float) f forPart:(NSString *) partName;
- (void) setScaleY:(float) f forPart:(NSString *) partName;

- (void) setScaleX:(float) sx;
- (void) setScaleY:(float) sy;

- (CGPoint) primaryPartOffset; // Can we kill this?

- (void) detachParts;

@end
