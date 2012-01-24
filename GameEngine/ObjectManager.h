//
//  ObjectManager.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Level.h"

@interface ObjectManager : NSObject {
    
    NSMutableSet *activeObjects;
    NSMutableSet *inactiveObjects;
    NSMutableSet *alwaysActiveObjects;
    
    @private
    Level *currentLevel;
    
}

@property (nonatomic, retain) NSMutableSet *activeObjects;
@property (nonatomic, retain) NSMutableSet *inactiveObjects;
@property (nonatomic, retain) NSMutableSet *alwaysActiveObjects;

- (id) init;
+ (id) manager;
- (void) setup;

- (id) initWithLevel:(Level *) l;
+ (id) managerWithLevel:(Level *) l;
- (void) setupWithLevel:(Level *) l;

- (void) dealloc;

- (void) setLevel:(Level *) l;

- (void) update:(double) dt;

@end
