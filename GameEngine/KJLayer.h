//
//  KJLayer.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJCommonGameObject.h"
#import "KJCamera.h"

extern NSString *const kjLayerObjects;
extern NSString *const kjActiveCameraId;
extern NSString *const kjCameraScale;
extern NSString *const kjCameraOffset;
extern NSString *const moduleLayer;

/** KJLayer is a conceptual container for GameObjects. These containers will hold a reference to the current camera. The layer properties in combination with the referenced camera will determine where the objects on this layer are drawn. */

/** Objects hold a reference to their world position and don't care what layer they are on. When an object resides in a layer, the screen position is modified by the current camera. When an object is not on a layer, cameras do not affect them. This may be confusing and should be reconsidered at some point. */

/** Handling of the drawing will occur at the game level. Adding a module, such as a Cocos2dLayerModule can handle the drawing...*/

@interface KJLayer : KJCommonGameObject

@property (nonatomic, retain) NSMutableSet *children;
@property (nonatomic, retain) KJCamera *activeCamera;
@property (nonatomic, assign) float cameraScale;
@property (nonatomic, assign) CGPoint cameraOffset;

+ (id) layer;
+ (id) layerWithDictionary:(NSDictionary *)dictionary;

- (KJModule *) layerModule;

@end
