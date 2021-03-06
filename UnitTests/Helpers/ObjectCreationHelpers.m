//
//  ObjectCreationHelpers.m
//  GameEngine
//
//  Created by Kevin Jenkins on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjectCreationHelpers.h"

@implementation ObjectCreationHelpers

#pragma mark - Dictionary Creation
+ (NSDictionary *) sampleObjectDictionary
{
    NSString *pathToObjectDictionary = [[NSBundle bundleForClass:[self class]] pathForResource:@"sampleObjectDictionary"
                                                                                        ofType:@"plist" ];
    NSDictionary *objectsDictionary = [NSDictionary dictionaryWithContentsOfFile:pathToObjectDictionary];
    return objectsDictionary;
}

+ (NSDictionary *) animationDictionary
{
    NSString *pathToObjectDictionary = [[NSBundle bundleForClass:[self class]] pathForResource:@"sampleAnimationDictionary"
                                                                                        ofType:@"plist" ];
    NSDictionary *animationsDictionary = [NSDictionary dictionaryWithContentsOfFile:pathToObjectDictionary];
    NSDictionary *animationDictionary = [animationsDictionary objectForKey:[NSString stringWithString:@"animationSet1"]];
    return animationDictionary;
}

+ (NSDictionary *) graphicsPartDictionary
{
    return [[[self animationDictionary] objectForKey:kjObjectParts] objectForKey:@"part1"];
}

+ (NSDictionary *) timeLineDictionary
{
    return [[[self graphicsPartDictionary] objectForKey:kjPartAnimations] objectForKey:@"animation1"];
}

+ (NSDictionary *) keyFrameDictionary
{
    return [[[self timeLineDictionary] objectForKey:kjTimeLineKeyFrames] objectAtIndex:1];
}

+ (NSDictionary*) moduleDictionary
{
    NSDictionary *moduleDictionary = [[self sampleObjectDictionary] objectForKey:@"module1"];
    return moduleDictionary;
}

+ (NSDictionary*) incrementingModuleDictionary
{
    NSDictionary *moduleDictionary = [[self sampleObjectDictionary] objectForKey:@"module2"];
    return moduleDictionary;
}

+ (NSDictionary*) commonGameObjectDictionary
{
    NSDictionary *dictionary = [[self sampleObjectDictionary] objectForKey:@"commonGameObject"];
    return dictionary;
}

#pragma mark - Game Object Helpers
+ (KJGameObject *) gameObjectFromDictionary
{
    NSDictionary *objectDictionary = [[self sampleObjectDictionary] objectForKey:[NSString stringWithString:@"gameObject"]];
    return [KJGameObject objectWithDictionary:objectDictionary];
}

#pragma mark - Layer Object Helpers
+ (KJLayer *) layerObjectFromDictionary
{
    NSDictionary *layerDictionary = [[self sampleObjectDictionary] objectForKey:[NSString stringWithString:@"layerObject"]];
    return [KJLayer objectWithDictionary:layerDictionary];
}

#pragma mark - Physics Object Helpers
+ (KJPhysicsObject *) createDefaultPhysicsObject
{
    KJPhysicsObject *newObject = [KJPhysicsObject object];
    return newObject;
}

+ (KJPhysicsObject *) createPhysicsObjectWithDictionary
{
    NSDictionary *objectDictionary = [[self sampleObjectDictionary] objectForKey:[NSString stringWithString:@"physicsGameObject"]];

    KJPhysicsObject *newObject = [KJPhysicsObject objectWithDictionary:objectDictionary];
    return newObject;
}

#pragma mark - Graphical Object Helpers
+ (KJGraphicalObject *) createDefaultGraphicalObject
{
    KJGraphicalObject *newObject = [KJGraphicalObject object];
    return newObject;
}

+ (KJGraphicalObject *) createGraphicalObjectWithDictionary
{
    NSDictionary *objectDictionary = [[self sampleObjectDictionary] objectForKey:[NSString stringWithString:@"graphicalGameObject"]];

    KJGraphicalObject *newObject = [KJGraphicalObject objectWithDictionary:objectDictionary];
    return newObject;
}

#pragma mark - Background Object Helpers
+ (KJBackgroundObject *) createDefaultBackgroundObject
{
    KJBackgroundObject *newBackgroundObject = [KJBackgroundObject object];
    return newBackgroundObject;
}
+ (KJBackgroundObject *) createBackgroundObjectWithDictionary
{
    NSDictionary *objectDictionary = [[self sampleObjectDictionary] objectForKey:[NSString stringWithString:@"backgroundGameObject"]];

    KJBackgroundObject *newBackgroundObject = [KJBackgroundObject objectWithDictionary:objectDictionary];
    return newBackgroundObject;
}

#pragma mark - Graphics Objects Helpers
+ (KJKeyFrame *) createDefaultKeyFrameObject
{
    KJKeyFrame *defaultKeyFrame = [KJKeyFrame frame];
    return defaultKeyFrame;
}

+ (KJKeyFrame *) createKeyFrameWithDictionary
{
    NSDictionary *keyFrameDictionary = [self keyFrameDictionary];
    KJKeyFrame *keyFrameWithDictionary = [KJKeyFrame frameWithDictionary:keyFrameDictionary];
    return keyFrameWithDictionary;
}

+ (KJTimeLine *) createDefaultTimeLine
{
    KJTimeLine *defaultTimeLine = [KJTimeLine timeLine];
    return defaultTimeLine;
}

+ (KJTimeLine *) createTimeLineWithDictionary
{
    NSDictionary *timeLineDictionary = [self timeLineDictionary];
    KJTimeLine *timeLineFromDictionary = [KJTimeLine timeLineWithDictionary:timeLineDictionary];
    return timeLineFromDictionary;
}

+ (KJGraphicsPart *) createDefaultGraphicsPart
{
    KJGraphicsPart *defaultGraphicsPart = [KJGraphicsPart part];
    return defaultGraphicsPart;
}

+ (KJGraphicsPart *) createGraphicsPartWithDictionary
{
    NSDictionary *graphicsPartDictionary = [self graphicsPartDictionary];
    KJGraphicsPart *graphicsPartFromDictionary = [KJGraphicsPart partWithAnimationDictionary:graphicsPartDictionary];
    return graphicsPartFromDictionary;
}

#pragma mark - Module Helpers
+ (KJModule*) createDefaultModule
{
    KJModule *defaultModule = [KJModule module];
    return defaultModule;
}

+ (KJModule*) createModuleWithDictionary
{
    KJModule* initializedModule = [KJModule moduleWithDictionary:[self moduleDictionary]];
    return initializedModule;
}

+ (KJModule*) createIncrementingModuleWithDictionary
{
    KJModule* incrementingModule = [KJModule moduleWithDictionary:[self incrementingModuleDictionary]];
    return incrementingModule;
}

#pragma mark - Common Game Object Helpers
+ (KJCommonGameObject*) createDefaultCommonGameObject
{
    KJCommonGameObject* commonGameObject = [KJCommonGameObject object];
    return commonGameObject;
}

+ (KJCommonGameObject*) createCommonGameObjectWithDictionary
{
    KJCommonGameObject* commonGameObject = [KJCommonGameObject objectWithDictionary:[self commonGameObjectDictionary]];
    return commonGameObject;
}

@end
