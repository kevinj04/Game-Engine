//
//  KJGameEventController.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJLevelLoader.h"

extern NSString *const kjNewGameNotification;
extern NSString *const kjContinueGameNotification;
extern NSString *const kjLoadGameNotification;
extern NSString *const kjQuitGameNotification;
extern NSString *const kjSaveGameNotification;
extern NSString *const kjOptionsNotification;

extern NSString *const kjLoadLevelNotification;
extern NSString *const kjQuitLevelNotification;
extern NSString *const kjRetryLevelNotification;

// exists to manage game notifications (new game, quit, save? options)

@interface KJGameEventController : NSObject 

@property (nonatomic, retain) KJLevelLoader *loader;

- (void) handleNewGameNotification:(NSNotification *) notification;
- (void) handleContinueGameNotification:(NSNotification *) notification;
- (void) handleLoadGameNotification:(NSNotification *) notification;
- (void) handleQuitGameNotification:(NSNotification *) notification;
- (void) handleSaveGameNotification:(NSNotification *) notification;
- (void) handleOptionsNotification:(NSNotification *) notification;

- (void) handleLoadLevelNotification:(NSNotification *) notification;
- (void) handleQuitLevelNotification:(NSNotification *) notification;
- (void) handleRetryLevelNotification:(NSNotification *) notification;

@end
