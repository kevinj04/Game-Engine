//
//  CocosBackgroundElement.h
//  TestGame
//
//  Created by Kevin Jenkins on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BackgroundTile.h"
#import "SpriteBGObject.h"

@interface CocosBackgroundElement : NSObject<GraphicsProtocol> {
        
    @private
    CCSprite *backgroundSprite;
    NSDictionary *backgroundElements;
}

- (id) initWithSpriteBGObject:(SpriteBGObject *) bgObj;
+ (id) backgroundElementWithSpriteBGObject:(SpriteBGObject *) bgObj;
- (void) setupWithSpriteBGObject:(SpriteBGObject *) bgObj;
- (void) dealloc;

- (void) update:(double)dt;
- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *) updateObj;

- (void) attachToLayer:(CCLayer *) layer;

@end
