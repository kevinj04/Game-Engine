//
//  Spawner.m
//  physics
//
//  Created by Kevin Jenkins on 12/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Spawner.h"
#import "Universalizer.h"
#import "GameElement.h"

NSString *const pSpawnChance = @"spawnChance";
NSString *const pSpawnDelay = @"spawnDelay";
NSString *const pSpawnRegion = @"spawnRegion";
NSString *const pSpawnPool = @"spawnPool";

NSString *const spawnObject = @"spawnObject";
NSString *const reclaimObject = @"reclaimObject";

@interface Spawner (hidden) 
- (void) registerNotifications;
- (void) reclaimHandler:(NSNotification *) notification;
- (void) spawnHandler:(NSNotification *) notification;
@end

@implementation Spawner (hidden)
- (void) registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(spawnHandler:) name:spawnObject object:self];
}
- (void) reclaimHandler:(NSNotification *) notification {
    NSObject<Spawnable> *obj = (NSObject<Spawnable> *)[notification object];
    [self reclaim:obj];
}
- (void) spawnHandler:(NSNotification *) notification {
    
    if ([spawnableObjects count] > 0) {
        
        NSObject<Spawnable> *obj = [spawnableObjects anyObject];
        [spawnedObjects addObject:obj];
        [spawnableObjects removeObject:obj];
        
        [self spawnObject:obj];
    }
    
    
}
@end


@implementation Spawner

- (id) init {
    
    if (( self = [super init] )) {
        
        [self setup];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) spawner {
    return [[[Spawner alloc] init] autorelease];
}
- (void) setup {
    
    [super setup];
    
    spawnRegion = CGRectMake(0, 0, 1, 1);
    
    spawnChance = 1.0;
    spawnDelay = 0.0;
    delayCounter = 0.0;
    
    spawnedObjects = [[NSMutableSet alloc] initWithCapacity:50];
    spawnableObjects = [[NSMutableSet alloc] initWithCapacity:50];
}

- (id) initWithDictionary:(NSDictionary *) dictionary {
    
    if (( self = [super initWithDictionary:dictionary])) {
        
        [self setupWithDictionary:dictionary];
        return self;
        
    } else {
        return nil;
    }
}
+ (id) spawnerWithDictionary:(NSDictionary *) dictionary {
    return [[[Spawner alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    [self setup];
    
    [super setupWithDictionary:dictionary];
    
    if ([dictionary objectForKey:parameters] != nil) {
        
        NSDictionary *params = [dictionary objectForKey:parameters];
        
        if ([params objectForKey:pSpawnRegion] != nil) {
            spawnRegion = [Universalizer scaleRectForIPad:CGRectFromString([params objectForKey:pSpawnRegion])];
        }
        
        if ([params objectForKey:pSpawnChance] != nil) {
            spawnChance = [[params objectForKey:pSpawnChance] floatValue];
        }
        
        
        if ([params objectForKey:pSpawnDelay] != nil) {
            spawnDelay = [[params objectForKey:pSpawnDelay] floatValue];
        }
        
    }
    
}
- (void) dealloc {
    
    if (spawnableObjects != nil) { [spawnableObjects release]; spawnableObjects = nil; }
    if (spawnedObjects != nil) { [spawnedObjects release]; spawnedObjects = nil; }
    
    [super dealloc];
}


- (void) addToSpawnablePool:(NSObject<GameElementProtocol> *) obj {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reclaimHandler:) name:reclaimObject object:obj];
    [spawnableObjects addObject:obj];
}

- (void) update:(double) dt {
    
    if ([self isActive]) {
        delayCounter += dt;
        
        if (delayCounter > spawnDelay) {
            
            delayCounter = 0.0;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:spawnObject object:self userInfo:nil];
            
            
        }
        
        
    }
    
    [super update:dt];
    
}

/** settings */
- (void) setSpawnRegion:(CGRect) r {
    spawnRegion = r;
}
- (void) setSpawnChance:(float) sc {
    spawnChance = sc;
}
- (void) setSpawnDelay:(float) sd {
    spawnDelay = sd;
}
- (NSMutableSet *) spawnedObjects {
    return spawnedObjects;
}
/** end settings */

- (void) spawnObject:(NSObject<Spawnable> *) obj {
        
    CGPoint startPoint = ccpInRect(spawnRegion);
    [obj spawnAt:startPoint];
    
}
- (void) reclaim:(NSObject<Spawnable> *) obj {
    //[obj reclaim];
    [spawnableObjects addObject:obj];
}


@end
