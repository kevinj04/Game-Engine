//
//  GameElement.m
//  physics
//
//  Created by Kevin Jenkins on 12/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GameElement.h"

NSString *const geObjectType = @"type";
NSString *const geObjectId = @"id";
NSString *const geObjectName = @"name";
NSString *const parameters = @"parameters";
NSString *const geSelected = @"gameElementSelected";

@interface GameElement (hidden) 
- (void) registerNotifications;
/*
 - (void) setupButton;
- (void) updateButton;
- (void) buttonDownHandler:(NSNotification *) notification;
 */
@end

@implementation GameElement (hidden)

- (void) registerNotifications {
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonDownHandler:) name:@"GEButtonDown" object:button];
}
/*
- (void) setupButton {
    bool buttonActive = YES;
    button = [[SneakyButton alloc] initWithRect:boundary];
    [button setButtonName:[NSString stringWithFormat:@"GEButton"]];
    [button setIsOn:buttonActive];
    [self addChild:button z:0];
    [self updateButton];
}
- (void) updateButton {
    button.boundingBox = [self boundary];
}
- (void) buttonDownHandler:(NSNotification *) notification {
    [[NSNotificationCenter defaultCenter] postNotificationName:geSelected object:self];
}
 */
@end

@implementation GameElement

@synthesize objectType, objectId, objectName;

- (id) init {
    
    if (( self = [super init] )) {
        
        [self registerNotifications];
        
        return self;
    } else {
        return nil;
    }
    
}
- (id) initWithDictionary:(NSDictionary *)dictionary {
    
    if (( self = [super init] )) {
        
        [self setupWithDictionary:dictionary];
        return self;
    } else {
        return nil;
    }
    
}
+ (id) element {
    return [[[GameElement alloc] init] autorelease];
}
+ (id) elementWithDictionary:(NSDictionary *) dictionary {
    return [[[GameElement alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setup {
    
    //[super setup];
    
    objectType = 0;
    objectId = @"defaultObjectId";
    objectName = @"defaultObjectName";
    
    active = YES;
    //[self setupButton];
    
    [self registerNotifications];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    
    if ([dictionary objectForKey:geObjectType] != nil) {
        objectType = [[dictionary objectForKey:geObjectType] intValue];
    }
    
    if ([dictionary objectForKey:geObjectId] != nil) {
        objectId = [[dictionary objectForKey:geObjectId] retain];
    }
    
    if ([dictionary objectForKey:geObjectName] != nil) {
        objectName = [[dictionary objectForKey:geObjectName] retain];
    }
    
}
- (void) dealloc {
    [super dealloc];
}

- (void) update:(double) dt {
    
    //[super update:dt];
    
    //[self updateButton];
}

/** Spawnable Code */
- (void) spawnAt:(CGPoint) p {
    [self setPosition:p];
    [self setVisible:YES];
    [self setActive:YES];
}

- (void) reclaim {
    [self setVisible:NO];
    [self setActive:NO];    
}
/** End Spawnable */

- (NSMutableDictionary *) dictionary {
    NSMutableDictionary *d = [[NSMutableDictionary dictionary] retain];
    
    [d setObject:[NSNumber numberWithInt:objectType] forKey:geObjectType];
    [d setObject:objectId forKey:geObjectId];
    [d setObject:objectName forKey:geObjectName];
    [d setObject:[NSMutableDictionary dictionaryWithCapacity:10] forKey:parameters];
    
    return d;
}
- (void) resetWithDictionary:(NSDictionary *) dictionary {
    
    [self setObjectType:[[dictionary objectForKey:geObjectType] intValue]];
    [self setObjectId:[dictionary objectForKey:geObjectId]];
    [self setObjectName:[dictionary objectForKey:geObjectName]];
    
}

- (bool) isActive {
    return active;
}
- (void) setActive:(bool) b {
    active = b;
}

@end
