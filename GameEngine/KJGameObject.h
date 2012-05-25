//
//  KJGameObject.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KJGameObjectProtocol.h>

// is this still needed?

@class KJLayer;


extern NSString *const kjParentId;
extern NSString *const kjObjectType;
extern NSString *const kjObjectId;
extern NSString *const kjObjectName;
extern NSString *const kjAlwaysActive;
extern NSString *const kjParameters;
extern NSString *const kjSelected;

@interface KJGameObject : NSObject<KJGameObjectProtocol> 

@property (nonatomic, retain) KJLayer *parent;
@property (nonatomic, retain) NSString *parentId;

@property (nonatomic, retain) NSString *objectName;
@property (nonatomic, retain) NSString *objectId;
@property (nonatomic, assign) kjElementType objectType;

@property (nonatomic, assign) bool isActive;
@property (nonatomic, assign) bool isAlwaysActive;

- (id) init;
+ (id) object;
- (void) setup;
- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) objectWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *)dictionary;
- (void) registerNotifications;
- (void) dealloc;

- (void) update:(double) dt;

@end
