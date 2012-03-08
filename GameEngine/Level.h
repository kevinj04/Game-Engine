//
//  Level.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PhysicsObject.h"
#import "BackgroundTile.h"
#import "CameraObject.h"
#import "HUDObject.h"

extern NSString *const levelInfo;
extern NSString *const levelName;
extern NSString *const levelLength;
extern NSString *const levelBGMusic;
extern NSString *const levelStartPoint;
extern NSString *const levelBgs;
extern NSString *const levelCameras;
extern NSString *const levelObjects;
extern NSString *const levelHUDs;
extern NSString *const levelResources;
extern NSString *const levelGraphics;
extern NSString *const levelSound;
extern NSString *const levelWAV;
extern NSString *const levelMP3;

extern NSString *const gameElementCreatedNotification;

@interface Level : NSObject {
    
    NSString *name;
    NSString *backgroundMusic;
    
    CGPoint startCoordinates;
    CGPoint startCameraCoordinates;
    
    int length;
    
    NSDictionary *objectDictionary;
    NSDictionary *backgroundTileDictionary;
    NSDictionary *cameraDictionary;
    NSDictionary *hudDictionary;
    
    @private
    NSArray *imageResources;
    NSArray *soundFXResources;
    NSArray *musicResources;
    
}

/** @brief The display name of the level. */
@property (nonatomic, retain) NSString *name;
/** @brief The file name of the background music. */
@property (nonatomic, retain) NSString *backgroundMusic;

/** @brief The initial coordinates of the main character. */
@property CGPoint startCoordinates;
/** @brief The initial coordinates of the main camera. */
@property CGPoint startCameraCoordinates;

/** @brief The length of the level in pixels. */
@property int length;

/** @brief A dictionary of all game elements. */
@property (nonatomic, retain) NSDictionary *objectDictionary;
/** @brief A dictionary of all background tile elements. */
@property (nonatomic, retain) NSDictionary *backgroundTileDictionary;
/** @brief A dictionary of all camera objects. */
@property (nonatomic, retain) NSDictionary *cameraDictionary;
/** @brief A dictionary of all HUD elements. */
@property (nonatomic, retain) NSDictionary *hudDictionary;

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) levelWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) setupLevel:(NSDictionary *) dictionary;
- (void) loadObjectsFromDictionary:(NSDictionary *) dictionary;
- (void) loadBackgroundTilesFromDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

- (NSArray *) imageResources;
- (NSArray *) soundFXResources;
- (NSArray *) musicResources;

@end

