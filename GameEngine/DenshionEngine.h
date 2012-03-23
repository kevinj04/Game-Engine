//
//  DenshionEngine.h
//  GameEngine
//
//  Created by Kevin Jenkins on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CocosDenshion.h"
#import "SimpleAudioEngine.h"
#import "CDAudioManager.h"
#import "SoundEngineProtocol.h"

typedef enum {
	kGSUninitialised, 
	kGSAudioManagerInitialising,  
	kGSAudioManagerInitialised,
	kGSLoadingSounds,
	kGSOkay,//only use when in this state
	kGSFailed
} geSoundState;


@interface DenshionEngine : NSObject<SoundEngineProtocol> {
    
    SimpleAudioEngine *sae;
    CDAudioManager *audio;
    
    geSoundState state;
        
    
    @private 
    NSString *currentMusic;
    NSMutableSet *preloadedEffects;
}

- (id) init;
- (void) setupEngine;
- (void) setupSound;
- (void) setupAsync;

@end
