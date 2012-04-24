//
//  SpawnerZManager.m
//  GameEngine
//
//  Created by Kevin Jenkins on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpawnerZManager.h"


@implementation SpawnerZManager

NSString *const spawnerZRange = @"zRange";

- (id) init {
    if (( self = [super init])) {                
        return self;
    } else {
        return nil;
    }
}
+ (id) spawner {
    return [[[SpawnerZManager alloc] init] autorelease];
}
- (void) setup {
    [super setup];
    
    zAvailable = [[NSMutableSet alloc] initWithCapacity:zRange];
    zUsed = [[NSMutableArray alloc] initWithCapacity:zRange];
    
    for (int i=0; i<zRange; i++) {
        [zAvailable addObject:[NSNumber numberWithInt:i]];
        [zUsed insertObject:[NSNumber numberWithInt:-1] atIndex:i];
    }
    
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    if ([dictionary objectForKey:parameters] != nil) {
        
        NSDictionary *params = [dictionary objectForKey:parameters];        
        
        zRange = 1;
        if ([params objectForKey:spawnerZRange] != nil) {
            zRange = [[params objectForKey:spawnerZRange] intValue];
        }
    }
    
    [super setupWithDictionary:dictionary];
}

- (id) initWithDictionary:(NSDictionary *) dictionary {
    if (( self = [super initWithDictionary:dictionary] )) {
        return self;
    } else {
        return nil;
    }
}
+ (id) spawnerWithDictionary:(NSDictionary *) dictionary {
    return [[[SpawnerZManager alloc] initWithDictionary:dictionary] autorelease];
}
- (void) dealloc {
    if (zAvailable != nil) { [zAvailable release]; zAvailable = nil; }
    if (zUsed != nil) { [zUsed release]; zUsed = nil; }
    
    [super dealloc];
}

- (void) spawnObject:(NSObject<SpawnableZ> *) obj {
    
    NSNumber *z = [zAvailable anyObject];
    
    [zUsed replaceObjectAtIndex:[z intValue] withObject:z];
    [zAvailable removeObject:z];
    
    [obj setZOrder:[z intValue]];
    
    [super spawnObject:obj];
    
}
- (void) reclaim:(NSObject<SpawnableZ> *) obj {
    
    NSNumber *z = [zUsed objectAtIndex:[obj zOrder]];
    
    [zAvailable addObject:z];
    
    if ([z intValue] > [zUsed count]) {
        NSLog(@"Insertion out of bounds for Object[%@] with index %i and zOrder %i", obj, [z intValue], [obj zOrder]);
    }
    
    [zUsed replaceObjectAtIndex:[z intValue] withObject:[NSNumber numberWithInt:-1]];
    
    [super reclaim:obj];
}

- (void) setZAvailable:(NSMutableSet *) s {
    if (zAvailable != nil) { [zAvailable release]; zAvailable = nil; }    
    zAvailable = [s retain];
}
- (void) setZUsed:(NSMutableArray *) s {
    if (zUsed != nil) { [zUsed release]; zUsed = nil; }
    zUsed = [s retain];
}

@end
