//
//  KJObjectSelector.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJGameObjectProtocol.h"
#import "KJLayer.h"
#import "KJLevel.h"
#import "KJCamera.h"

@interface KJObjectSelector : NSObject

+ (void) setCurrentLevel:(KJLevel *) level;
+ (NSObject<KJGameObjectProtocol> *) getAnyObjectById:(NSString *) idString;

+ (KJCommonGameObject *) getObjectById:(NSString *) idString;
+ (NSArray *) allObjects;

+ (KJLayer *) getLayerById:(NSString *) idString;
+ (NSArray *) allLayers;

+ (KJCamera *) getCameraById:(NSString *) idString;
+ (NSArray *) allCameras;

@end
