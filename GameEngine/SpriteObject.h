//
//  SpriteObject.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphicsProtocol.h"

extern NSString *const spriteObjectParts;
extern NSString *const spriteObjectAnimations;
extern NSString *const spriteObjectRunningAnimation; 
extern NSString *const spriteVertexZ;
extern NSString *const spriteZOrder;
extern NSString *const spriteBody;
extern NSString *const spriteShouldIgnoreBatchNodeUpdate;

/**
 
 SpriteObject is the graphic representation of a GameElement. It can be composed of any number of sprite parts. Animations are managed by TimeLines which control a series of KeyFrames. When the SpriteObject is updated with a time step, the parts positions, scales, rotations, and sprite frames are updated accordingly -- eased between the expected KeyFrames. 
 
 */

@interface SpriteObject : NSObject<SpriteUpdateProtocol> {
    
    // SpriteObject is a 'container' of sprite parts.
    NSString *objectName;
    
    CGPoint position;
    float rotation;
    float scaleX;
    float scaleY;
    double animationSpeed;
    float vertexZ;
    int zOrder;
    CGPoint anchorPoint;
    CGRect boundingBox;
    BOOL visible;
    bool flipX;
    BOOL flipY;
    
    BOOL shouldIgnoreBatchNodeUpdate;
    
    @private    
    NSDictionary *parts;
    NSString *primarySprite;
    
}

@property (nonatomic, retain) NSString *objectName;

@property CGPoint position;
@property float rotation;
@property float scaleX;
@property float scaleY;
@property double animationSpeed;

@property float vertexZ;
@property int zOrder;

@property CGPoint anchorPoint;
@property CGRect boundingBox;
@property BOOL visible;
@property bool flipX;
@property BOOL flipY;
@property BOOL shouldIgnoreBatchNodeUpdate;

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) objectWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

- (void) update:(double) dt;
- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *) pObj;

- (void) runAnimation:(NSString *) animationName onPart:(NSString *) partName;
- (void) runAnimation:(NSString *) animationName;

- (void) setPosition:(CGPoint) p forPart:(NSString *) partName;
- (void) setRotation:(float)r forPart:(NSString *) partName;
- (void) setFlipX:(_Bool) b forPart:(NSString *) partName;
- (void) setFlipY:(_Bool) b forPart:(NSString *) partName;
- (void) setScaleX:(float) f forPart:(NSString *) partName;
- (void) setScaleY:(float) f forPart:(NSString *) partName;

- (NSDictionary *) parts;

- (CGPoint) childBasePosition;
- (void) setScaleX:(float) sx;
- (void) setScaleY:(float) sy;

- (CGPoint) frameOffset;

@end
