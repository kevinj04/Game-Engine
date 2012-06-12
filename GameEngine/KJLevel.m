//
//  KJLevel.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJLevel.h"
#import "KJCommonGameObject.h"

NSString *const kjLevelInfo = @"Info";
NSString *const kjLevelName = @"name";
NSString *const kjObjects = @"Objects";
NSString *const kjCameras = @"Cameras";
NSString *const kjLayers = @"Layers";
NSString *const kjBackgrounds = @"Backgrounds";
NSString *const kjLevelBGMusic = @"backgroundMusic";
NSString *const kjLevelBgs = @"Backgrounds";
NSString *const kjLevelResources = @"Resources";
NSString *const kjLevelGraphics = @"Graphics";
NSString *const kjLevelSound = @"Sound";
NSString *const kjLevelWAV = @"WAV";
NSString *const kjLevelMP3 = @"MP3";
NSString *const kjLevelActiveWindow = @"activeWindow";

NSString *const kjGameObjectCreatedNotification = @"gameElementCreatedNotification";

@interface KJLevel (private)
- (void) handleElementCreatedNotification:(NSNotification *) notification;
@end

@implementation KJLevel (hidden)
- (void) handleObjectCreatedNotification:(NSNotification *) notification {
    
    NSObject<KJGameObjectProtocol> *geObj = [notification object];
    NSLog(@"Level[%@] -- Notified of the creation of %@, adding to our list of objects.", self, [geObj objectId]);
    [self addObject:geObj];
    
}

@end

@implementation KJLevel

@synthesize name = _name;
@synthesize backgroundMusic = _backgroundMusic;
@synthesize defaultLayer = _defaultLayer;
@synthesize activeCamera = _activeCamera;
@synthesize objectDictionary = _objectDictionary;
@synthesize layerDictionary = _layerDictionary;
@synthesize cameraDictionary = _cameraDictionary;
@synthesize activeWindow = _activeWindow;

#pragma mark -

#pragma mark Initialization Methods
- (id) initWithDictionary:(NSDictionary *) dictionary 
{
    if (( self = [super init] )) {
 
        [self registerNotifications];
        [self setupWithDictionary:dictionary];
        return self;
        
    }
    return nil;
}
+ (id) levelWithDictionary:(NSDictionary *) dictionary
{
    return [[[KJLevel alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setup {
    // future use?
}
- (void) setupWithDictionary:(NSDictionary *) dictionary 
{    
    
    self.activeWindow = CGRectZero;
    
    NSDictionary *d = [dictionary objectForKey:kjLevelInfo];
    self.name = [d objectForKey:kjLevelName];
    self.backgroundMusic = [d objectForKey:kjLevelBGMusic];
    self.activeWindow = CGRectFromString([d objectForKey:kjLevelActiveWindow]);
    
    imageResources = [[[dictionary objectForKey:kjLevelResources] objectForKey:kjLevelGraphics] retain];
    soundFXResources = [[[[dictionary objectForKey:kjLevelResources] objectForKey:kjLevelSound] objectForKey:kjLevelWAV] retain];
    musicResources = [[[[dictionary objectForKey:kjLevelResources] objectForKey:kjLevelSound] objectForKey:kjLevelMP3] retain];
    
    self.activeCamera = nil;
    self.defaultLayer = nil;
    
    self.objectDictionary = [NSMutableDictionary dictionaryWithCapacity:1000];    
    self.layerDictionary  = [NSMutableDictionary dictionaryWithCapacity:20];
    self.cameraDictionary  = [NSMutableDictionary dictionaryWithCapacity:20];
}
- (void) registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleObjectCreatedNotification:) name:kjGameObjectCreatedNotification object:nil];
}
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.name != nil) { [_name release]; self.name = nil; }
    if (self.backgroundMusic != nil) { [_backgroundMusic release]; self.name = nil; }
    
    if (self.layerDictionary != nil) { [_layerDictionary release]; self.layerDictionary = nil; }
    if (self.objectDictionary != nil) { [_objectDictionary release]; self.objectDictionary = nil; }
    if (self.cameraDictionary != nil) { [_cameraDictionary release]; self.cameraDictionary = nil; }
    
    [super dealloc];
}
#pragma mark -


#pragma mark Loading Methods
- (void) loadObjects:(NSDictionary *) dictionary {
    
    for (NSDictionary *objectSpec in [dictionary allValues]) {                
        KJCommonGameObject *cObj = [KJCommonGameObject objectWithDictionary:objectSpec];
        [[NSNotificationCenter defaultCenter] postNotificationName:kjGameObjectCreatedNotification object:cObj];
    }
    
}
- (void) addObject:(NSObject<KJGameObjectProtocol> *) obj {
    [self.objectDictionary setObject:obj forKey:[obj objectId]];
}
- (void) loadLayers:(NSDictionary *) dictionary 
{
    for (NSDictionary *layerSpec in [dictionary allValues])
    {
        KJLayer *layer = [KJLayer layerWithDictionary:layerSpec];
        [self addLayer:layer];
    }
    
    // A default layer is always created. Any object that does not specify a layer to be added to will end up on this one.
    [self addLayer:[self createDefaultLayer]];
}
- (void) addLayer:(KJLayer *) layer 
{
    [self.layerDictionary setObject:layer forKey:[layer objectId]];
}

- (KJLayer *) createDefaultLayer
{
    // override if needed
    
    KJLayer *layer = [KJLayer layer];
    layer.objectId = [NSString stringWithFormat:@"defaultLayer"];
    layer.objectName = [NSString stringWithFormat:@"defaultLayer"];
    layer.objectType = 4; // this is probably wrong
    [self setDefaultLayer:layer];
    return layer;
}

- (void) loadCameras:(NSDictionary *) dictionary
{
    for (NSDictionary *cameraSpec in [dictionary allValues])
    {
        KJCamera *camera = [KJCamera cameraWithDictionary:cameraSpec];
        
        if ([[[self cameraDictionary] allValues] count] == 0)
        {
            self.activeCamera = camera;
        }
        
        [self addCamera:camera];
        
    }
    
    if ([[[self cameraDictionary] allValues] count] == 0)
    {
        [self addCamera:[self createDefaultCamera]];
    }
    
    // If no cameras are created, a default camera is created. If multiple cameras are created, the first one is set to the active camera.
}
- (void) addCamera:(KJCamera *) camera
{
    [self.cameraDictionary setObject:camera forKey:[camera objectId]];
}
- (KJCamera *) createDefaultCamera
{
    // override if needed
    
    KJCamera *camera = [KJCamera camera];
    camera.objectId = [NSString stringWithFormat:@"defaultCamera"];
    camera.objectName = [NSString stringWithFormat:@"defaultCamera"];
    camera.objectType = 3;
    [self setActiveCamera:camera];
    return camera;
}
#pragma mark -


#pragma mark Getters and Setters
- (NSArray *) imageResources
{
    return imageResources;
}
- (NSArray *) soundFXResources
{
    return soundFXResources;
}
- (NSArray *) musicResources
{
    return musicResources;
}
#pragma mark -

#pragma mark - Debug Aids
- (void) logAllObjects 
{
    NSLog(@"\n");
    NSLog(@"Level %@", self.name);
    NSLog(@"\n");
    NSLog(@"=====+++Cameras+++=====");
    for (KJCamera *camera in [self.cameraDictionary allValues]) 
    {
        NSLog(@"\t%@[%@]", [camera objectId], camera);
    }
    NSLog(@"\n");
    NSLog(@"=====+++Layers+++=====");
    for (KJLayer *layer in [self.layerDictionary allValues]) 
    {
        NSLog(@"\t%@[%@]", [layer objectId], layer);
    }
    NSLog(@"\n");
    NSLog(@"=====+++Game Objects+++=====");
    for (KJCommonGameObject *gameObj in [self.objectDictionary allValues]) 
    {
        NSLog(@"\t%@[%@]", [gameObj objectId], gameObj);
    }
    NSLog(@"\n");
}


@end
