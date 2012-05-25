//
//  KJCocosComplexSpriteObject.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJCocosGraphicObject.h"
#import "KJGraphicalObject.h"

@interface KJCocosComplexSpriteObject : KJCocosGraphicObject {
    
    CCSpriteBatchNode *batchNode;
    NSDictionary *sprites;
    
}

- (id) initWithGraphicalObject:(KJGraphicalObject *) sObj;
+ (id) objectWithGraphicalObject:(KJGraphicalObject *) sObj;
- (void) setupWithGraphicalObject:(KJGraphicalObject *) sObj;
- (void) dealloc;

- (void) update:(double)dt;
- (void) updateComplexBoundingBox;

- (void) attachToLayer:(CCLayer *) layer;
- (void) setBatchNode:(CCSpriteBatchNode *) sbn;
- (CCSpriteBatchNode *) batchNode;

@end
