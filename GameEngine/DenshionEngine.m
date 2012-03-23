//
//  DenshionEngine.m
//  GameEngine
//
//  Created by Kevin Jenkins on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DenshionEngine.h"

static BOOL setupHasRun;

@implementation DenshionEngine

- (id) init {
    
    if((self=[super init])) {
		sae = nil;
		state = kGSUninitialised;
		setupHasRun = NO;	
        preloadedEffects = [[NSMutableSet alloc] initWithCapacity:50];
		
		return self;
	} else {
		return nil;
	}
    
}
+ (id) engine {
    return [[[DenshionEngine alloc] init] autorelease];
}
- (void) setupEngine {
    //Make sure this only runs once
	if (setupHasRun) {
		return;
	} else {
		setupHasRun = YES;
	}	
	
	//This code below is just using the NSOperation framework to run the asynchrounousSetup method in another thread.
	//Note: we do not use asynchronous loading to speed up loading, it is done so other things can occur while the loading
	//is happening. For example display a loading screen to the user.
	NSOperationQueue *queue = [[NSOperationQueue new] autorelease];
	NSInvocationOperation *asynchSetupOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(setupAsync) object:nil];
	[queue addOperation:asynchSetupOperation];
    [asynchSetupOperation autorelease];

}
- (void) setupSound {
    state = kGSAudioManagerInitialising;
	
	//Set up the mixer rate for sound engine. This must be done before the audio manager is initialised.
	//For performance Apple recommends having all your samples at the same sample rate and setting the mixer rate to the same value.
	//22050 Hz (CD_SAMPLE_RATE_MID) gives a nice balance between quality, performance and memory usage but you may want to
	//use a higher value for certain applications such as music games.
	[CDSoundEngine setMixerSampleRate:CD_SAMPLE_RATE_MID];
	
	//Initialise audio manager asynchronously as it can take a few seconds
	//The FXPlusMusicIfNoOtherAudio mode will check if the user is playing music and disable background music playback if 
	//that is the case.
	[CDAudioManager initAsynchronously:kAMM_FxPlusMusicIfNoOtherAudio];

}
- (void) setupAsync {
    [self setupSound];
	
	//Wait for the audio manager to initialise
	while ([CDAudioManager sharedManagerState] != kAMStateInitialised) {
		[NSThread sleepForTimeInterval:0.1];
	}	
	
	state = kGSAudioManagerInitialised;
	//Note: although we are using SimpleAudioEngine this is built on top of the shared instance of CDAudioManager.
	//Therefore it is safe to access the shared instance of CDAudioManager if necessary.
    audio = [CDAudioManager sharedManager];
	if (audio.soundEngine == nil || audio.soundEngine.functioning == NO) {
		//Something has gone wrong - we have no audio
		state = kGSFailed;
	} else {
		
		//If you are using background music you probably want to do this. Basically it makes sure your background music
		//is paused and resumed properly when the application is resigned and resumed. Without it you will find that
		//music you had paused will restart even if you don't want it to or your music will start playing sooner than
		//you want.
		[audio setResignBehavior:kAMRBStopPlay autoHandle:YES];
		
		state = kGSLoadingSounds;
		
		sae = [SimpleAudioEngine sharedEngine];
		
		//[self preload];
		
		// can preload music here
		
		state = kGSOkay;
		
	}

}


- (void) setVolume:(float)volume {
    [sae setBackgroundMusicVolume:volume];
    [sae setEffectsVolume:volume];
}
- (void) muteMusic {
    [sae stopBackgroundMusic];
}
- (void) unmuteMusic {
    if ([sae isBackgroundMusicPlaying]) {
        [sae resumeBackgroundMusic];
    } else {
        [self playMusic:currentMusic];
    }
}
- (void) muteAll {
    [sae setMute:YES];
}
- (void) unmuteAll {
    [sae setMute:NO];
}


- (void) preloadMusic:(NSString *)trackName {
    [sae preloadBackgroundMusic:trackName];
}

- (void) preloadEffect:(NSString *)trackName {
    [sae preloadEffect:trackName];
    [preloadedEffects addObject:trackName];
}

- (void) unloadMusic:(NSString *) trackName {
    // nothing to do?
    
}

- (void) unloadEffect:(NSString *) trackName {
    [sae unloadEffect:trackName];
}

- (void) unloadEffects {
    for (NSString *effectName in preloadedEffects) {
        [sae unloadEffect:effectName];
    }
    
}

- (void) unloadMusic {
    // nothing to do
}

- (void) playMusic:(NSString *) trackName {
    currentMusic = [trackName retain];
    [sae playBackgroundMusic:currentMusic loop:YES];
}
- (void) pauseMusic {
    [sae pauseBackgroundMusic];
}
- (void) playEffect:(NSString *) effectName {
    [sae playEffect:effectName];
}

@end
