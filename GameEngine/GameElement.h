//
//  GameElement.h
//  physics
//
//  Created by Kevin Jenkins on 12/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
//#import "Spawnable.h"
#import "GameElementProtocol.h"
#import "CGExtensions.h"
//#import "SneakyButton.h"

extern NSString *const geObjectType;
extern NSString *const geObjectId;
extern NSString *const geObjectName;
extern NSString *const parameters;
extern NSString *const geSelected;

typedef enum elementType {
    etObject, etSpriteObject, etCamera, etHUD
} elementType;

@interface GameElement : CCNode<GameElementProtocol> {
    
    NSString *objectName;
    NSString *objectId;
    elementType objectType; 
    
    @private 
    //SneakyButton *button;
    bool active;
    
}

@property (nonatomic, retain) NSString *objectName;
@property (nonatomic, retain) NSString *objectId;
@property elementType objectType;

- (id) init;
+ (id) element;
- (void) setup;
- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) elementWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *)dictionary;
- (void) dealloc;

- (void) update:(double) dt;

- (void) spawnAt:(CGPoint) p;
- (void) reclaim;

- (NSMutableDictionary *) dictionary;
- (void) resetWithDictionary:(NSDictionary *) dictionary;

- (bool) isActive;
- (void) setActive:(bool) b;

@end
