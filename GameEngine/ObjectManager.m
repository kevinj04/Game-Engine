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
- (void) levelChanged;
@end

@implementation ObjectManager (hidden)
- (void) levelChanged {
    
    // todo: Change this to reflect active/inactive, for now, everything is active
    
    for (GameElement *ge in [[currentLevel objectDictionary] allValues]) {
        [activeObjects addObject:ge];
    }
    
    for (GameElement *ge in [[currentLevel backgroundTileDictionary] allValues]) {
        [activeObjects addObject:ge];
    }
    
    for (GameElement *ge in [[currentLevel hudDictionary] allValues]) {
        [alwaysActiveObjects addObject:ge];
    }
    
    for (GameElement *ge in [[currentLevel cameraDictionary] allValues]) {
        [alwaysActiveObjects addObject:ge];
    }
    
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
    if (currentLevel != nil) { [currentLevel release]; currentLevel = nil; }
    currentLevel = [l retain];
    [self levelChanged];
}

@end
