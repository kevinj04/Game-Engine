//
//  KJGameEventController.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJGameEventController.h"

NSString *const kjNewGameNotification = @"newGame";
NSString *const kjLoadGameNotification = @"loadGame";
NSString *const kjQuitGameNotification = @"quitGame";
NSString *const kjSaveGameNotification = @"saveGame";
NSString *const kjOptionsNotification = @"showOptions";

NSString *const kjLoadLevelNotification = @"loadLevel";
NSString *const kjQuitLevelNotification = @"quitLevel";
NSString *const kjRetryLevelNotification = @"retryLevel";

@interface KJGameEventController (hidden)
- (void) registerNotifications;
@end

@implementation KJGameEventController (hidden)
- (void) registerNotifications 
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNewGameNotification:) name:kjNewGameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoadGameNotification:) name:kjLoadGameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleQuitGameNotification:) name:kjQuitGameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSaveGameNotification:) name:kjSaveGameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleOptionsNotification:) name:kjOptionsNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoadLevelNotification:) name:kjLoadLevelNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleQuitLevelNotification:) name:kjQuitLevelNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRetryLevelNotification:) name:kjRetryLevelNotification object:nil];
}
@end

@implementation KJGameEventController

@synthesize loader = _loader;

- (id)init
{
    self = [super init];
    if (self) {
        
        self.loader = [[KJLevelLoader loader] retain];
        
        [self registerNotifications];
        
        [self setup];
    }
    return self;
}

- (void) setupLevelLoader
{
    // ?
}

- (void) setup
{
    [self setupLevelLoader];
}

- (void) dealloc 
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.loader != nil) { [self.loader release]; self.loader = nil; }
    
    [super dealloc];
}

#pragma mark Event Handlers

- (void) handleNewGameNotification:(NSNotification *) notification 
{
    // override me
}
- (void) handleContinueGameNotification:(NSNotification *) notification 
{
    // override me
}
- (void) handleLoadGameNotification:(NSNotification *) notification 
{
    // override me
}
- (void) handleQuitGameNotification:(NSNotification *) notification 
{
    // override me
}
- (void) handleSaveGameNotification:(NSNotification *) notification
{
    // override me
}
- (void) handleOptionsNotification:(NSNotification *) notification
{
    // override me
}

- (void) handleLoadLevelNotification:(NSNotification *) notification
{
    // override me   
}
- (void) handleQuitLevelNotification:(NSNotification *) notification
{
    // override me
}
- (void) handleRetryLevelNotification:(NSNotification *) notification\
{
    // override me    
}

#pragma mark -

@end
