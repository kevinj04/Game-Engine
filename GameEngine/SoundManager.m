//
//  SoundManager.m
//  GameEngine
//
//  Created by Kevin Jenkins on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SoundManager.h"

@implementation SoundManager

SYNTHESIZE_SINGLETON_FOR_CLASS(SoundManager);

- (id) init {
    if (( self = [super init] )) {
        
        [self setup];
        return self;
        
    } else {
        return nil;
    }
}
+ (id) manager {
    return [[[SoundManager alloc] init] autorelease];
}
- (void) setup {
    
}
- (id) initWithSoundEngine:(NSObject<SoundEngineProtocol> *) e {
    if (( self = [super init] )) {
        
        [self setupWithSoundEngine:e];
        return self;
        
    } else {
        return nil;
    }
}
+ (id) managerWithSoundEngine:(NSObject<SoundEngineProtocol> *) e {
    return [[[SoundManager alloc] initWithSoundEngine:e] autorelease];
}
- (void) setupWithSoundEngine:(NSObject<SoundEngineProtocol> *) e {
    engine = [e retain];
}
- (void) dealloc {
    
    if (engine != nil) { [engine release]; engine = nil; }
    [super dealloc];
}

- (void) setSoundEngine:(NSObject<SoundEngineProtocol> *) e {
    if (engine != nil) { [engine release]; engine = nil; }
    engine = [e retain];
}

- (void) preloadMusic:(NSString *) trackName {
    [engine preloadMusic:trackName];
}
- (void) preloadEffect:(NSString *) effectName {
    [engine preloadEffect:effectName];
}
- (void) unloadMusic:(NSString *) trackName {
    [engine unloadMusic:trackName];
}
- (void) unloadEffect:(NSString *) trackName {
    [engine unloadEffect:trackName];
}
- (void) unloadEffects {
    [engine unloadEffects];
}
- (void) unloadMusic {
    [engine unloadMusic];
}

- (void) setVolume:(float) volumeLevel {
    [engine setVolume:volumeLevel];
}
- (void) muteMusic {
    [engine muteMusic];
}
- (void) unmuteMusic {
    [engine unmuteMusic];
}
- (void) muteAll {
    [engine muteAll];
}
- (void) unmuteAll {
    [engine unmuteAll];
    
}

- (void) playMusic:(NSString *) trackName {
    [engine playMusic:trackName];
}
- (void) pauseMusic {
    [engine pauseMusic];
}
- (void) playEffect:(NSString *) effectName {
    [engine playEffect:effectName];
}

@end
