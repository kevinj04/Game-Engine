//
//  SpritePart.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimeLine.h"
#import "GraphicsProtocol.h"
#import "SpriteObject.h"
/**
 
 A SpritePart is a functional unit of a SpriteObject. These are single sprites that may be part of a complex entity. They contain a set of animations (represented by TimeLine objects) and can run a single animation.
 
 */

extern NSString *const partAnimations;
extern NSString *const partRunningAnimation;
extern NSString *const partVertexZ;
extern NSString *const partZOrder;
extern NSString *const partAnchorPoint;

@interface SpritePart : NSObject<GraphicsProtocol, SpriteUpdateProtocol> {
    
    NSString *name;
    
    @private
    NSObject<GraphicsProtocol> *spriteRep;
    
    TimeLine *currentTimeLine;
    NSDictionary *animations;
    
    SpriteObject *parent; 

    
    /** Sprite Info */
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

    
}

@property (nonatomic, retain) NSString *name;

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
/** ------------------- **/


- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) partWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

- (void) update:(double) dt;
- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *)updateObj;
- (void) runAnimation:(NSString *) animationName;

- (void) setParent:(SpriteObject *) spriteObj;
- (void) setSpriteRep:(NSObject<GraphicsProtocol> *) rep;
- (NSObject<GraphicsProtocol> *) spriteRep;

@end
