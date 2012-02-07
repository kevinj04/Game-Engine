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

@interface CocosBackgroundElement : BackgroundTile {
        
    @private
    SpriteBGObject *graphics;
}

- (id) initWithDictionary:(NSDictionary *)dictionary andAnimationDictionary:(NSDictionary *) animationDictionary;
+ (id) backgroundElementWithDictionary:(NSDictionary *) dictionary andAnimationDictionary:(NSDictionary *) animationDictionary;
- (void) setupWithDictionary:(NSDictionary *)dictionary andAnimationDictionary:(NSDictionary *) animationDictionary;
- (void) dealloc;

- (void) update:(double)dt;

- (void) attachToLayer:(CCLayer *) layer;

@end
