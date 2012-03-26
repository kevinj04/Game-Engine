//
//  CocosComplexSpriteElement.h
//  TestGame
//
//  Created by Kevin Jenkins on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpriteObject.h"
#import "CocosGraphicElement.h"

extern NSString *const zOrderStr;

/**
 
 A cocos2d based sprite element composed of multiple SpriteParts. This makes use of a CCSpriteBatch node to optimize drawing.
 
 */

@interface CocosComplexSpriteElement : CocosGraphicElement {
    
    @private
    CCSpriteBatchNode *batchNode;
    NSDictionary *sprites;    

}

- (id) initWithSpriteInfo:(SpriteObject *) sObj;
+ (id) spriteElementWithSpriteInfo:(SpriteObject *) sObj;
- (void) setupWithSpriteInfo:(SpriteObject *) sObj;
- (void) dealloc;

- (void) update:(double)dt;
- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *)updateObj;

- (void) attachToLayer:(CCLayer *) layer;
- (void) setBatchNode:(CCSpriteBatchNode *) sbn;
- (CCSpriteBatchNode *) batchNode;

@end
