//
//  Spawner.h
//  physics
//
//  Created by Kevin Jenkins on 12/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameElementProtocol.h"
#import "PhysicsObject.h"

extern NSString *const pSpawnChance;
extern NSString *const pSpawnDelay;
extern NSString *const pSpawnRegion;
extern NSString *const pSpawnPool;

extern NSString *const spawnObject;
extern NSString *const reclaimObject;

@interface Spawner : PhysicsObject {
    
@private
    CGRect spawnRegion;
    
    float spawnChance;
    ccTime spawnDelay;
    ccTime delayCounter;
    
    NSMutableSet *spawnedObjects;
    NSMutableSet *spawnableObjects;
    
}

- (id) init;
+ (id) spawner;
- (void) setup;
- (void) setupWithDictionary:(NSDictionary *) dictionary;

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) spawnerWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

- (void) addToSpawnablePool:(GameElement<Spawnable> *) obj;

- (void) update:(double) dt;

/** settings */
- (void) setSpawnRegion:(CGRect) r;
- (void) setSpawnChance:(float) sc;
- (void) setSpawnDelay:(float) sd;
- (NSMutableSet *) spawnedObjects;
/** end settings */

@end
