//
//  Spawner.h
//  physics
//
//  Created by Kevin Jenkins on 12/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Spawnable.h"
#import "PhysicsObject.h"

extern NSString *const pSpawnChance;
extern NSString *const pSpawnDelay;
extern NSString *const pSpawnRegion;

extern NSString *const spawnObject;
extern NSString *const reclaimObject;

@interface Spawner : PhysicsObject<Spawnable> {
    
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

- (void) update:(ccTime) dt;

/** settings */
- (void) setSpawnRegion:(CGRect) r;
- (void) setSpawnChance:(float) sc;
- (void) setSpawnDelay:(float) sd;
- (NSMutableSet *) spawnedObjects;
/** end settings */

@end
