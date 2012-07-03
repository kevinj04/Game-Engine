//
//  ObjectCreationHelpers.h
//  GameEngine
//
//  Created by Kevin Jenkins on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "kjEngine.h"

@interface ObjectCreationHelpers : NSObject

+ (NSDictionary *) sampleObjectDictionary;
+ (NSDictionary *) animationDictionary;

+ (KJLayer *) layerObjectFromDictionary;
+ (KJGameObject *) gameObjectFromDictionary;
+ (KJPhysicsObject *) createPhysicsObjectWithDictionary;
+ (KJPhysicsObject *) createDefaultPhysicsObject;
+ (KJGraphicalObject *) createGraphicalObjectWithDictionary;
+ (KJGraphicalObject *) createDefaultGraphicalObject;

+ (KJKeyFrame *) createDefaultKeyFrameObject;
+ (KJKeyFrame *) createKeyFrameWithDictionary;
+ (KJTimeLine *) createDefaultTimeLine;
+ (KJTimeLine *) createTimeLineWithDictionary;
+ (KJGraphicsPart *) createDefaultGraphicsPart;
+ (KJGraphicsPart *) createGraphicsPartWithDictionary;

@end
