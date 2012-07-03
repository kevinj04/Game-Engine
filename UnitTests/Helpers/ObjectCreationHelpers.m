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

+ (NSDictionary *) graphicPartDictionary
{
    return [[[self animationDictionary] objectForKey:kjObjectParts] objectForKey:@"part1"];
}

+ (NSDictionary *) timeLineDictionary
{
    return [[[self graphicPartDictionary] objectForKey:kjPartAnimations] objectForKey:@"animation1"];
}

+ (NSDictionary *) keyFrameDictionary
{
    return [[[self timeLineDictionary] objectForKey:kjTimeLineKeyFrames] objectAtIndex:1];
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
@end
