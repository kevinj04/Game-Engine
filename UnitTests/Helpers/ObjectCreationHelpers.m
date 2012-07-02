//
//  ObjectCreationHelpers.m
//  GameEngine
//
//  Created by Kevin Jenkins on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjectCreationHelpers.h"

@implementation ObjectCreationHelpers

+ (NSDictionary *) sampleObjectDictionary
{
    NSString *pathToObjectDictionary = [[NSBundle bundleForClass:[self class]] pathForResource:@"sampleObjectDictionary"
                                                                                        ofType:@"plist" ];
    NSDictionary *objectsDictionary = [NSDictionary dictionaryWithContentsOfFile:pathToObjectDictionary];
    return objectsDictionary;
}

- (NSDictionary *) animationDictionary
{
    NSString *pathToObjectDictionary = [[NSBundle bundleForClass:[self class]] pathForResource:@"sampleAnimationDictionary"
                                                                                        ofType:@"plist" ];
    NSDictionary *animationsDictionary = [NSDictionary dictionaryWithContentsOfFile:pathToObjectDictionary];
    NSDictionary *animationDictionary = [animationsDictionary objectForKey:[NSString stringWithString:@"graphicSet1"]];
    return animationDictionary;
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

@end
