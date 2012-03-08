//
//  Level.m
//  GameEngine
//
//  Created by Kevin Jenkins on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level.h"

@interface Level (private)
- (void) registerNotifications;
- (void) handleElementCreatedNotification:(NSNotification *) notification;
@end

@implementation Level (private)
- (void) registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleElementCreatedNotification:) name:gameElementCreatedNotification object:nil];
}
- (void) handleElementCreatedNotification:(NSNotification *) notification {
    
    NSObject<GameElementProtocol> *geObj = [notification object];
    
    switch ([geObj objectType]) {
        case etObject:
            [objectDictionary setObject:geObj forKey:[geObj objectId]];
            break;
        case etSpriteObject:
            [objectDictionary setObject:geObj forKey:[geObj objectId]];
            break;
        case etCamera:
            [cameraDictionary setObject:geObj forKey:[geObj objectId]];
            break;
        case etHUD:
            [hudDictionary setObject:geObj forKey:[geObj objectId]];
            break;
            
        default:
            break;
    }
    
}
@end


@implementation Level

NSString *const levelInfo = @"Info";
NSString *const levelName = @"levelName";
NSString *const levelLength = @"length";
NSString *const levelBGMusic = @"backgroundMusic";
NSString *const levelStartPoint = @"startPoint";
NSString *const levelBgs = @"Backgrounds";
NSString *const levelCameras = @"Cameras";
NSString *const levelObjects = @"Objects";
NSString *const levelHUDs = @"HUDs";
NSString *const levelResources = @"Resources";
NSString *const levelGraphics = @"Graphics";
NSString *const levelSound = @"Sound";
NSString *const levelWAV = @"WAV";
NSString *const levelMP3 = @"MP3";

NSString *const gameElementCreatedNotification = @"gameElementCreatedNotification";

@synthesize name;
@synthesize backgroundMusic;
@synthesize startCoordinates, startCameraCoordinates;
@synthesize length;

@synthesize objectDictionary, backgroundTileDictionary, cameraDictionary, hudDictionary;


- (id) initWithDictionary:(NSDictionary *) dictionary {
    if (( self = [super init] )) {
        
        [self setupWithDictionary:dictionary];
        
        return self;
        
    } else {
        return nil;
    }
}
+ (id) levelWithDictionary:(NSDictionary *) dictionary {
    return [[[Level alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    [self registerNotifications];
    
    [self setupLevel:dictionary];
    
    [self loadObjectsFromDictionary:dictionary];
    
    [self loadBackgroundTilesFromDictionary:dictionary];
    
}
- (void) setupLevel:(NSDictionary *) dictionary {
    
    NSDictionary *d = [dictionary objectForKey:levelInfo];
    name = [[d objectForKey:levelName] retain];
    backgroundMusic = [[d objectForKey:levelBGMusic] retain];
    length = [[d objectForKey:levelLength] intValue];
    
    imageResources = [[[dictionary objectForKey:levelResources] objectForKey:levelGraphics] retain];
    soundFXResources = [[[[dictionary objectForKey:levelResources] objectForKey:levelSound] objectForKey:levelWAV] retain];
    musicResources = [[[[dictionary objectForKey:levelResources] objectForKey:levelSound] objectForKey:levelMP3] retain];
    
    objectDictionary = [[NSMutableDictionary alloc] initWithCapacity:1000];
    hudDictionary = [[NSMutableDictionary alloc] initWithCapacity:100];
    cameraDictionary = [[NSMutableDictionary alloc] initWithCapacity:100];
}

- (void) loadObjectsFromDictionary:(NSDictionary *) dictionary {
    
    NSDictionary *objects = [[dictionary objectForKey:levelObjects] retain];    
    
    for (NSDictionary *objDictionary in objects) {
        
        elementType et = (elementType)[[objDictionary objectForKey:geObjectType] intValue];
        
        PhysicsObject *pObj;
        
        switch (et) {
            case etObject:
                pObj = [PhysicsObject objectWithDictionary:objDictionary];
                break;
                
            case etCamera:
                pObj = [CameraObject objectWithDictionary:objDictionary];
                break;
                
            case etHUD:
                pObj = [HUDObject objectWithDictionary:objDictionary];
                break;
                
            default:
                pObj = [PhysicsObject objectWithDictionary:objDictionary];
                break;
        }                
        
        // maybe someday split out non-camera, non-hud?
        [[NSNotificationCenter defaultCenter] postNotificationName:gameElementCreatedNotification            
                                                            object:pObj
                                                          userInfo:nil];
        
    }
    
}
- (void) loadBackgroundTilesFromDictionary:(NSDictionary *) dictionary {
    NSDictionary *bgs = [[dictionary objectForKey:levelBgs] retain];
    
    NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionaryWithCapacity:[bgs count]];
    
    for (NSDictionary *bgDictionary in bgs) {
        
        BackgroundTile *tile = [BackgroundTile tileWithDictionary:bgDictionary];
        [tempDictionary setObject:tile forKey:[tile objectId]];
        
    }
    
    backgroundTileDictionary= [[NSMutableDictionary alloc] initWithDictionary:tempDictionary];
}

- (void) dealloc {
    
    if (name != nil) { [name release]; name = nil; }
    if (backgroundMusic != nil) { [backgroundMusic release]; backgroundMusic = nil; }
    if (objectDictionary != nil) { [objectDictionary release]; objectDictionary = nil; }
    if (backgroundTileDictionary != nil) { [backgroundTileDictionary release]; backgroundTileDictionary = nil; }
    if (cameraDictionary != nil) { [cameraDictionary release]; cameraDictionary = nil; }
    if (hudDictionary != nil) { [hudDictionary release]; hudDictionary = nil; }
    
    if (imageResources != nil) { [imageResources release]; imageResources = nil; }
    if (soundFXResources != nil) { [soundFXResources release]; soundFXResources = nil; }
    if (musicResources != nil) { [musicResources release]; musicResources = nil; }
    
    [super dealloc];
}

- (NSArray *) imageResources {
    return imageResources;
}
- (NSArray *) soundFXResources {
    return soundFXResources;
}
- (NSArray *) musicResources {
    return musicResources;
}



@end
