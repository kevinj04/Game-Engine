//
//  SpawnerZManager.h
//  GameEngine
//
//  Created by Kevin Jenkins on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Spawner.h"
#import "SpawnableZ.h"


extern NSString *const spawnerZRange;
extern NSString *const spawnerZBase;

@interface SpawnerZManager : Spawner {
    
    int zBase;
    int zRange;
    
    NSMutableSet *zAvailable;
    NSMutableArray *zUsed;
        
}

- (id) init;
+ (id) spawner;
- (void) setup;
- (void) setupWithDictionary:(NSDictionary *) dictionary;

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) spawnerWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

- (void) update:(double)dt;

- (void) spawnObject:(NSObject<SpawnableZ> *) obj;
- (void) reclaim:(NSObject<SpawnableZ> *) obj;

// Use the external setters to link spawnerZManagers so that they share a common pool of z indecies.
- (void) setZAvailable:(NSMutableSet *) s;
- (void) setZUsed:(NSMutableArray *) s;
- (void) setZBase:(int) z;
- (void) setZRange:(int) z;

@end
