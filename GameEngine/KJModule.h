//
//  KJModule.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const modClass;
extern NSString *const modId;
extern NSString *const modHashSuffix;
extern NSString *const modAtSuffix;

extern NSString *const modAnimationRequest;

@class KJCommonGameObject;
@class KJLayer;

@interface KJModule : NSObject {

}

@property (nonatomic, retain) KJCommonGameObject *parent;
@property (nonatomic, retain) KJLayer *parentLayer;
@property (nonatomic, retain) NSString *moduleName;
@property (nonatomic, retain) NSString *moduleId;

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) module;
+ (id) moduleWithDictionary:(NSDictionary *) dictionary;
+ (int) kjModuleIdTag;
+ (int) lastIdTag;

- (void) setup;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithGameObject:(KJCommonGameObject *) obj;

- (void) dealloc;

- (void) update:(double) dt;

- (void) setParent:(KJCommonGameObject *) p;
- (KJCommonGameObject *) parent;

- (void) detach;

@end
