//
//  ObjectSelector.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameElementProtocol.h"
#import "Level.h"

@interface ObjectSelector : NSObject {
    
}

+ (void) setCurrentLevel:(Level *) level;
+ (NSObject<GameElementProtocol> *) getObjectById:(NSString *) idString;
+ (NSObject<GameElementProtocol> *) getCameraById:(NSString *) idString;
+ (NSObject<GameElementProtocol> *) getBackgroundById:(NSString *) idString;
+ (NSObject<GameElementProtocol> *) getHUDById:(NSString *) idString;

@end
