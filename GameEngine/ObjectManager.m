//
//  ObjectManager.m
//  GameEngine
//
//  Created by Kevin Jenkins on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjectManager.h"
#import "GameElement.h"

@interface ObjectManager (hidden)

- (void) unloadCurrentLevel;
@end

@implementation ObjectManager (hidden)
- (void) unloadCurrentLevel {
    
    //[self showActiveObjects];
    //[self showAlwaysActiveObjects];
    //NSLog(@"  BEFORE ^^^^^^^^^^^^^^^^ UNLOAD[%@] :: %@", currentLevel, [currentLevel name]);
    
    int oldCount = 0;
    for (GameElement *ge in [[currentLevel objectDictionary] allValues]) {
        oldCount = [activeObjects count];
        [activeObjects removeObject:ge];
        //NSLog(@"Removing Object[%@]: %@   (active object count was: %i   now: %i", ge, [ge objectName], oldCount, [activeObjects count]);
    }
    
    for (GameElement *ge in [[currentLevel backgroundTileDictionary] allValues]) {
        oldCount = [activeObjects count];
        [activeObjects removeObject:ge];
        //NSLog(@"Removing BG[%@]: %@   (active object count was: %i   now: %i", ge, [ge objectName], oldCount, [activeObjects count]);
    }
    
    for (GameElement *ge in [[currentLevel hudDictionary] allValues]) {
        oldCount = [alwaysActiveObjects count];
        [alwaysActiveObjects removeObject:ge];
        //NSLog(@"Removing HUD[%@]: %@   (always active object count was: %i   now: %i", ge, [ge objectName], oldCount, [alwaysActiveObjects count]);
    }
    
    for (GameElement *ge in [[currentLevel cameraDictionary] allValues]) {
        oldCount = [alwaysActiveObjects count];
        [alwaysActiveObjects removeObject:ge];
        //NSLog(@"Removing Camera[%@]: %@   (active object count was: %i   now: %i", ge, [ge objectName], oldCount, [alwaysActiveObjects count]);
    }
    //NSLog(@" AFTER VVVVVVVVVVVVV UNLOAD[%@] :: %@", currentLevel, [currentLevel name]);
    //[self showActiveObjects];
    //[self showAlwaysActiveObjects];

    
}
@end

@implementation ObjectManager

@synthesize alwaysActiveObjects, activeObjects, inactiveObjects;

- (id) init {
    
    if (( self = [super init] )) {
        
        [self setup];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) manager {
    return [[[ObjectManager alloc] init] autorelease];
}
- (void) setup {
    // todo: anything here?
    currentLevel = nil;
    
    activeObjects = [[NSMutableSet alloc] initWithCapacity:1000];
    inactiveObjects = [[NSMutableSet alloc] initWithCapacity:1000];
    alwaysActiveObjects = [[NSMutableSet alloc] initWithCapacity:200];
}

- (id) initWithLevel:(Level *) l {
    
    self = [[ObjectManager alloc] init];
    if (self != nil) { [self setupWithLevel:l]; }
    
    return self;
}
+ (id) managerWithLevel:(Level *) l {
    return [[[ObjectManager alloc] initWithLevel:l] autorelease];
}
- (void) setupWithLevel:(Level *) l {
    
    [self setup];
    
    currentLevel = [l retain];
    [self levelChanged];
    
}

- (void) dealloc {
    
    if (currentLevel != nil) { [currentLevel release]; currentLevel = nil; }
    if (activeObjects != nil) { [activeObjects release]; activeObjects = nil; }
    if (alwaysActiveObjects != nil) { [alwaysActiveObjects release]; alwaysActiveObjects = nil; }
    if (inactiveObjects != nil) { [inactiveObjects release]; inactiveObjects = nil; }
    
    [super dealloc];
    
}

- (void) setLevel:(Level *) l {
    if (currentLevel != nil) { [self unloadCurrentLevel]; [currentLevel release]; currentLevel = nil; }
    currentLevel = [l retain];
    [self levelChanged];
}
- (void) levelChanged {
    
    // todo: Change this to reflect active/inactive, for now, everything is active
    
    //[self showActiveObjects];
    //[self showAlwaysActiveObjects];
    //NSLog(@"  BEFORE ^^^^^^^^^^^^^^^^ LOAD[%@] :: %@", currentLevel, [currentLevel name]);
    
    int oldCount = 0;
    for (GameElement *ge in [[currentLevel objectDictionary] allValues]) {
        oldCount = [activeObjects count];
        [activeObjects addObject:ge];
        //NSLog(@"Adding Object[%@]: %@   (active object count was: %i   now: %i", ge, [ge objectName], oldCount, [activeObjects count]);
    }
    
    for (GameElement *ge in [[currentLevel backgroundTileDictionary] allValues]) {
        oldCount = [activeObjects count];
        [activeObjects addObject:ge];
        //NSLog(@"Adding Object[%@]: %@   (active object count was: %i   now: %i", ge, [ge objectName], oldCount, [activeObjects count]);
    }
    
    for (GameElement *ge in [[currentLevel hudDictionary] allValues]) {
        oldCount = [alwaysActiveObjects count];
        [alwaysActiveObjects addObject:ge];
        //NSLog(@"Adding HUD[%@]: %@   (always active object count was: %i   now: %i", ge, [ge objectName], oldCount, [alwaysActiveObjects count]);
    }
    
    for (GameElement *ge in [[currentLevel cameraDictionary] allValues]) {
        oldCount = [alwaysActiveObjects count];
        [alwaysActiveObjects addObject:ge];
        //NSLog(@"Adding HUD[%@]: %@   (always active object count was: %i   now: %i", ge, [ge objectName], oldCount, [alwaysActiveObjects count]);
    }
    
    //NSLog(@" AFTER VVVVVVVVVVVVV UNLOAD[%@] :: %@", currentLevel, [currentLevel name]);
    //[self showActiveObjects];
    //[self showAlwaysActiveObjects];
    
    
}


- (void) update:(double) dt {
    for (NSObject<GameElementProtocol> *ge in alwaysActiveObjects) {
        [ge update:dt];
    }

    for (NSObject<GameElementProtocol> *ge in activeObjects) {
        [ge update:dt];
    }
}

- (void) showActiveObjects {    
    NSLog(@"There are %i active objects", [activeObjects count]);
    for (NSObject<GameElementProtocol> *ge in activeObjects) {
        NSLog(@"Active Object[%@]: %@", ge, [ge objectName]);
    }
}
- (void) showAlwaysActiveObjects {
    NSLog(@"There are %i always active objects", [alwaysActiveObjects count]);
    for (NSObject<GameElementProtocol> *ge in alwaysActiveObjects) {
        NSLog(@"Always Active Object[%@]: %@", ge, [ge objectName]);
    }

}

- (Level *) currentLevel {
    return currentLevel;
}

@end
