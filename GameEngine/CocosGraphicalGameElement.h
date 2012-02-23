//
//  CocosGraphicalGameElement.h
//  TestGame
//
//  Created by Kevin Jenkins on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameElement.h"
#import "PhysicsObject.h"
#import "GraphicsProtocol.h"
#import "SpriteObject.h"
#import "cocos2d.h"

@interface CocosGraphicalGameElement : PhysicsObject {
    
    @private
    SpriteObject *graphics;
    
}

- (id) initWithDictionary:(NSDictionary *)dictionary andAnimationDictionary:(NSDictionary *) animationDictionary;
+ (id) graphicalGameElementWithDictionary:(NSDictionary *) dictionary andAnimationDictionary:(NSDictionary *) animationDictionary;
- (void) setupWithDictionary:(NSDictionary *)dictionary andAnimationDictionary:(NSDictionary *) animationDictionary;
- (void) dealloc;

- (void) update:(double)dt;

- (void) attachToLayer:(CCLayer *) layer;
- (void) runAnimation:(NSString *) animationName;
- (void) runAnimation:(NSString *) animationName onPart:(NSString *)partName;
- (void) setAnimationSpeed:(double) animSpeed;

@end
