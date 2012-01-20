//
//  SpriteObject.m
//  GameEngine
//
//  Created by Kevin Jenkins on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpriteObject.h"
#import "TimeLine.h"

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
            
            NSDictionary *animationsDictionary = [[partsDictionary objectForKey:partName] objectForKey:spriteObjectAnimations];
            
            NSMutableDictionary *timeLines = [NSMutableDictionary dictionaryWithCapacity:[animationsDictionary count]];
            
            for (NSString *timeLineName in [animationsDictionary allKeys]) {
                
                NSDictionary *timeLineDictionary = [animationsDictionary objectForKey:timeLineName];
                TimeLine *tl = [TimeLine timeLineWithDictionary:timeLineDictionary];
                
                [timeLines setObject:tl forKey:timeLineName];
                
            }
            
            NSMutableDictionary *tempPart = [NSMutableDictionary dictionaryWithCapacity:2];
            [tempPart setObject:timeLines forKey:spriteObjectAnimations];
            
            if ([[partsDictionary objectForKey:partName] objectForKey:spriteObjectRunningAnimation] != nil) {
                [tempPart setObject:[[partsDictionary objectForKey:partName] objectForKey:spriteObjectRunningAnimation] forKey:spriteObjectRunningAnimation];
            }
            
            [tempParts setObject:tempPart forKey:partName];
        }
        
        parts = [[NSDictionary alloc] initWithDictionary:tempParts];
        
    } else {
        parts = [[NSDictionary alloc] init];
    }
    
    
}
- (void) dealloc {
    
    if (parts != nil) { [parts release]; parts = nil; }
    if (runningAnimations != nil) { [runningAnimations release]; runningAnimations = nil; }
    
    [super dealloc];
}

- (void) update:(double) dt {

    for (NSDictionary *partDictionary in parts) {
        
        if ([partDictionary objectForKey:spriteObjectRunningAnimation] != nil) {
            
            TimeLine *tl = [[partDictionary objectForKey:spriteObjectAnimations] objectForKey:[partDictionary objectForKey:spriteObjectRunningAnimation]];
            [tl update:dt];
            
        }
        
    }
    
    
}

- (void) runAnimation:(NSString *) animationName onPart:(NSString *) partName {
        
    // make sure the part exists
    if ([parts objectForKey:partName] != nil) {
        // make sure the animation exists for this part
        if ([[[parts objectForKey:partName] objectForKey:spriteObjectAnimations] 
             objectForKey:animationName] != nil) {
            
            [[parts objectForKey:partName] setObject:animationName forKey:spriteObjectRunningAnimation];
            
        }
        
    }
    
}
- (void) runAnimation:(NSString *) animationName {
    
    for (NSMutableDictionary *partDictionary in parts) {
        
        if ([partDictionary objectForKey:animationName] != nil) {
            
            [partDictionary setObject:animationName forKey:spriteObjectRunningAnimation];
            
        }
        
    }
    
}

@end
