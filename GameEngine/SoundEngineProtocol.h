//
//  SoundEngineProtocol.h
//  GameEngine
//
//  Created by Kevin Jenkins on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SoundEngineProtocol <NSObject>

- (void) setupEngine;
- (void) preloadMusic:(NSString *) trackName;
- (void) preloadEffect:(NSString *) trackName;

- (void) unloadMusic:(NSString *) trackName;
- (void) unloadEffect:(NSString *) trackName;
- (void) unloadEffects;
- (void) unloadMusic;

- (void) setVolume:(float) volume;
- (void) muteMusic;
- (void) unmuteMusic;
- (void) muteAll;
- (void) unmuteAll;

- (void) playMusic:(NSString *) trackName;
- (void) pauseMusic;
- (void) playEffect:(NSString *) effectName;

@end
