//
//  SoundManager.h
//  GameEngine
//
//  Created by Kevin Jenkins on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoundEngineProtocol.h"
#import "SynthesizeSingleton.h"

@interface SoundManager : NSObject {
    
    
    @private
    NSObject<SoundEngineProtocol> *engine;
}

- (id) init;
- (id) initWithSoundEngine:(NSObject<SoundEngineProtocol> *) e;
+ (id) manager;
+ (id) managerWithSoundEngine:(NSObject<SoundEngineProtocol> *) e;
- (void) setup;
- (void) setupWithSoundEngine:(NSObject<SoundEngineProtocol> *) e;
- (void) dealloc;

- (void) setSoundEngine:(NSObject<SoundEngineProtocol> *) e;

- (void) preloadMusic:(NSString *) trackName;;
- (void) preloadEffect:(NSString *) trackName;;
- (void) unloadMusic:(NSString *) trackName;
- (void) unloadEffect:(NSString *) trackName;
- (void) unloadEffects;
- (void) unloadMusic;

- (void) setVolume:(float) volumeLevel;
- (void) muteMusic;
- (void) unmuteMusic;
- (void) muteAll;
- (void) unmuteAll;

- (void) playMusic:(NSString *) trackName;
- (void) pauseMusic;
- (void) playEffect:(NSString *) effectName;

+ (SoundManager *) sharedSoundManager;


@end
