//
//  KJLevel.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJGameObjectProtocol.h"
#import "KJCamera.h"
#import "KJLayer.h"
#import <UIKit/UIKit.h>

extern NSString *const kjLevelInfo;
extern NSString *const kjLevelName;
extern NSString *const kjLevelBGMusic;
extern NSString *const kjLevelBgs;
extern NSString *const kjBackgrounds;
extern NSString *const kjObjects;
extern NSString *const kjCameras;
extern NSString *const kjLayers;
extern NSString *const kjLevelResources;
extern NSString *const kjLevelGraphics;
extern NSString *const kjLevelSound;
extern NSString *const kjLevelWAV;
extern NSString *const kjLevelMP3;

extern NSString *const kjGameObjectCreatedNotification;

@interface KJLevel : NSObject {
    
    @private
    NSArray *imageResources;
    NSArray *soundFXResources;
    NSArray *musicResources;
}

@property (nonatomic, assign) CGRect activeWindow;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *backgroundMusic;

@property (nonatomic, retain) KJLayer *defaultLayer;
@property (nonatomic, retain) KJCamera *activeCamera;

@property (nonatomic, retain) NSMutableDictionary *layerDictionary;
@property (nonatomic, retain) NSMutableDictionary *objectDictionary;
@property (nonatomic, retain) NSMutableDictionary *cameraDictionary;

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) levelWithDictionary:(NSDictionary *) dictionary;
- (void) setup;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) registerNotifications;
- (void) dealloc;

- (void) loadObjects:(NSDictionary *) dictionary;
- (void) addObject:(NSObject<KJGameObjectProtocol> *) obj;

- (void) loadLayers:(NSDictionary *) dictionary;
- (void) addLayer:(KJLayer *) layer;
- (KJLayer *) createDefaultLayer;

- (void) loadCameras:(NSDictionary *) dictionary;
- (void) addCamera:(KJCamera *) camera;
- (KJCamera *) createDefaultCamera;

- (NSArray *) imageResources;
- (NSArray *) soundFXResources;
- (NSArray *) musicResources;

- (void) logAllObjects;

@end