//
//  KJLevelStageProtocol.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KJLevelStageProtocol <NSObject>

@required
- (void) loadLevel:(KJLevel *) level;
- (void) unloadLevel:(KJLevel *) level;

@end
