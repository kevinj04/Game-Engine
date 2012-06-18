//
//  KJLayer.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJLayer.h"
#import "KJLevel.h"

NSString *const kjLayerObjects = @"objects";
NSString *const kjActiveCameraId = @"activeCameraId";
NSString *const kjCameraScale = @"cameraScale";
NSString *const kjCameraOffset = @"cameraOffset";
NSString *const moduleLayer = @"layer";

@implementation KJLayer

@synthesize children = _children;
@synthesize activeCamera = _activeCamera;
@synthesize cameraScale = _cameraScale;
@synthesize cameraOffset = _cameraOffset;
@synthesize maxVertexZ = _maxVertexZ;
@synthesize shouldReOrderAbove = _shouldReOrderAbove;

#pragma mark - Initialization/Setup/Dealloc
- (id) init
{
    self = [super init];
    return self;
}
+ (id) layer
{
    return [[[KJLayer alloc] init] autorelease];
}
- (id) initWithDictionary:(NSDictionary *)dictionary 
{
    
    self = [super initWithDictionary:dictionary];
    if (self) 
    {
        // setup?
    }
    return self;
}
+ (id) layerWithDictionary:(NSDictionary *) dictionary
{
    return [[[KJLayer alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *)dictionary 
{
    [super setup];
    [super setupWithDictionary:dictionary];
    
    self.children = [NSMutableSet setWithCapacity:20];
    self.activeCamera = nil;
    self.cameraScale = 1.0;
    self.cameraOffset = CGPointZero;
    
    NSDictionary *params = [dictionary objectForKey:kjParameters];
    if (params)
    {
        
        if ([params objectForKey:kjLayerObjects] != nil)
        {
            
            // load the objects here, set their parent to self.
            [self setupObjectsFromDictionary:[params objectForKey:kjLayerObjects]];
        }
        
        if ([params objectForKey:kjActiveCameraId] != nil) 
        {
            self.activeCamera = [params objectForKey:kjActiveCameraId];
        }
        
        if ([params objectForKey:kjCameraScale] != nil) 
        {
            self.cameraScale = [[params objectForKey:kjCameraScale] floatValue];
        }
        
        if ([params objectForKey:kjCameraOffset] != nil) 
        {
            self.cameraOffset = CGPointFromString([params objectForKey:kjCameraOffset]);
        }
        
    }
    
}
- (void) setupObjectsFromDictionary:(NSDictionary *) dictionary {
    
    // Override this function in most situations. Force it to create GameObjects that are higher level, relevant to the specific game.
    
    for (NSDictionary *objDictionary in [dictionary allValues]) {
        
        KJCommonGameObject *childObject = [KJCommonGameObject objectWithDictionary:objDictionary];                
        [self.children addObject:childObject];
        [childObject setIsActive:NO];
        [childObject setVisible:NO];
        [childObject setParentId:[self objectId]];
        [childObject setParent:self];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kjGameObjectCreatedNotification object:childObject];
    }
}
- (void) dealloc 
{
    
    if (self.children != nil) { [_children release]; self.children = nil;}
    if (self.activeCamera != nil) { [_activeCamera release]; self.activeCamera = nil; }
    
    [super dealloc];
}

#pragma mark Tick Method
- (void) update:(double) dt 
{
    [super update:dt];
    
    // update all children attached to the layer
    
    for (KJCommonGameObject *gameObj in self.children) 
    {
        [gameObj update:dt];
    }
    
    
}

- (KJModule *) layerModule 
{
    if ([self.modules objectForKey:moduleLayer] != nil) {
        return [self.modules objectForKey:moduleLayer];
    }
    return nil;
}

- (void) addChild:(KJGraphicalObject *) object atZOrder:(int) zOrder
{
    [self.children addObject:object];
    
    if (zOrder+self.vertexZ > self.maxVertexZ)
    {
        self.maxVertexZ = zOrder + self.vertexZ;
    }
}

- (void) addChildAtRandomZ:(KJGraphicalObject *) object
{
    [self.children addObject:object];
    object.zOrder = [self randomZDepth];
}

- (int) randomZDepth
{
    // override if special z management is taking place.
    return 0;
}

- (void) restoreZSpaceForObject:(KJGraphicalObject *) object
{
    // override if special z management is taking place.
    return;
}

- (void) setVertexZ:(float)z
{
    [super setVertexZ:z];
    
    // When the vertexZ of this layer is changed, all the children must shift as well.
    [self.children enumerateObjectsUsingBlock:^(KJGraphicalObject *obj, BOOL *stop) {
        obj.vertexZ = obj.zOrder + self.vertexZ;
    }];
    
}

@end
