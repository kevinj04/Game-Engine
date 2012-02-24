//
//  CocosComplexSpriteElement.h
//  TestGame
//
//  Created by Kevin Jenkins on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhysicsObject.h"
#import "SpriteObject.h"
#import "cocos2d.h"

extern NSString *const zOrderStr;

/**
 
 A cocos2d based sprite element composed of multiple SpriteParts. This makes use of a CCSpriteBatch node to optimize drawing.
 
 */

@interface CocosComplexSpriteElement : PhysicsObject {
    
    @private
    SpriteObject *graphics;
    CCSpriteBatchNode *batchNode;
    
    int rotationTemp;
    
}

- (id) initWithDictionary:(NSDictionary *)dictionary andAnimationDictionary:(NSDictionary *) animationDictionary;
+ (id) graphicalGameElementWithDictionary:(NSDictionary *) dictionary andAnimationDictionary:(NSDictionary *) animationDictionary;
- (void) setupWithDictionary:(NSDictionary *)dictionary andAnimationDictionary:(NSDictionary *) animationDictionary;
- (void) dealloc;

- (void) update:(double)dt;

- (void) attachToLayer:(CCLayer *) layer;
- (void) runAnimation:(NSString *) animationName;
- (void) runAnimation:(NSString *) animationName onPart:(NSString *)partName;

- (void) setRotation:(float)rotation;
- (void) setAnimationSpeed:(double) animSpeed;
- (void) setAnchorPoint:(CGPoint) ap;

@end
