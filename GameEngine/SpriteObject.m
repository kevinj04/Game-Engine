//
//  SpriteObject.m
//  GameEngine
//
//  Created by Kevin Jenkins on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpriteObject.h"
#import "TimeLine.h"
#import "SpritePart.h"

NSString *const spriteObjectParts = @"parts";
NSString *const spriteObjectAnimations = @"animations";
NSString *const spriteObjectRunningAnimation = @"runningAnimation";

@implementation SpriteObject

- (id) initWithDictionary:(NSDictionary *) dictionary {
    
    if (( self = [super init] )) {
        
        [self setupWithDictionary:dictionary];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) objectWithDictionary:(NSDictionary *) dictionary {
    return [[[SpriteObject alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    if ([dictionary objectForKey:spriteObjectParts] != nil) {
        
        NSDictionary *partsDictionary = [dictionary objectForKey:spriteObjectParts];
        
        NSMutableDictionary *tempParts = [NSMutableDictionary dictionaryWithCapacity:[partsDictionary count]];
        
        for (NSString *partName in [partsDictionary allKeys]) {
            
            SpritePart *part = [SpritePart partWithDictionary:[partsDictionary objectForKey:partName]];
            
            [tempParts setObject:part forKey:partName];
        }
        
        parts = [[NSDictionary alloc] initWithDictionary:tempParts];
        
    } else {
        parts = [[NSDictionary alloc] init];
    }
    
    
}
- (void) dealloc {
    
    if (parts != nil) { [parts release]; parts = nil; }
    
    [super dealloc];
}

- (void) update:(double) dt {

    for (SpritePart *part in [parts allValues]) {
        [part update:dt];
    }
        
}

- (void) runAnimation:(NSString *) animationName onPart:(NSString *) partName {
        
    // make sure the part exists
    if ([parts objectForKey:partName] != nil) {
        [[parts objectForKey:partName] runAnimation:animationName];        
    }
    
}
- (void) runAnimation:(NSString *) animationName {
    
    for (SpritePart *part in [parts allValues]) {
        [part runAnimation:animationName];
    }
    
}

- (void) setSpriteRep:(NSObject<GraphicsProtocol> *) rep forPart:(NSString *) partName {
    if ([parts objectForKey:partName] != nil) {
        [[parts objectForKey:partName] setSpriteRep:rep];
    }
}

- (NSDictionary *) parts {
    return parts;
}

@end
