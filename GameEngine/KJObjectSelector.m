//
//  KJObjectSelector.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJObjectSelector.h"

static KJLevel *currentLevel;

@implementation KJObjectSelector

+ (void) setCurrentLevel:(KJLevel *) level {
    currentLevel = level;
}

+ (KJCommonGameObject *) getAnyObjectById:(NSString *) idString {
    
    if (currentLevel == nil) return nil;
    
    KJCommonGameObject *object = (KJCommonGameObject *)[[currentLevel objectDictionary] objectForKey:idString];
    KJLayer *layer = (KJLayer *)[[currentLevel layerDictionary] objectForKey:idString];
    KJCamera *camera = (KJCamera *)[[currentLevel cameraDictionary] objectForKey:idString];
    
    int flag = 0;
    if (object != nil) flag++;
    if (layer != nil) flag++;
    if (camera != nil) flag++;
    
    if (flag == 1) {
        if (object) return object;
        if (layer) return layer;
        if (camera) return camera;
    }
    
    return nil;
}

+ (NSObject<KJGameObjectProtocol> *) getObjectById:(NSString *)idString {
    
    if (currentLevel == nil) { return  nil; }
    
    return [[currentLevel objectDictionary] objectForKey:idString];
    
}
+ (NSArray *) allObjects
{
    if (currentLevel == nil) { return nil; }
    return [[currentLevel objectDictionary] allValues];
}

+ (KJLayer *) getLayerById:(NSString *) idString 
{
    if (currentLevel == nil) { return nil; }
    
    return [[currentLevel layerDictionary] objectForKey:idString];
}
+ (NSArray *) allLayers 
{
    if (currentLevel == nil) { return nil; }
    return [[currentLevel layerDictionary] allValues];
}

+ (KJCamera *) getCameraById:(NSString *)idString
{
    if (currentLevel == nil) { return nil; }
    
    return [[currentLevel cameraDictionary] objectForKey:idString];
}
+ (NSArray *) allCameras 
{
    if (currentLevel == nil) { return nil; }
    return [[currentLevel cameraDictionary] allValues];
}

@end
