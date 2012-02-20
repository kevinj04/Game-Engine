//
//  SpriteRepresentation.m
//  TestGame
//
//  Created by Kevin Jenkins on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpriteRepresentation.h"
#import "cocos2d.h"

@interface SpriteRepresentation (hidden) 
- (void) updateColor;
@end

@implementation SpriteRepresentation (hidden)
- (void) updateColor {
    if ([spriteFrameName isEqualToString:@"BLUE"]) {
        glColor4ub(0,0,255,255);
    } else if ([spriteFrameName isEqualToString:@"PURPLE"]) {
        glColor4ub(123,0,255,255);
    } else if ([spriteFrameName isEqualToString:@"RED"]) {
        glColor4ub(255,0,0,255);
    } else if ([spriteFrameName isEqualToString:@"GREEN"]) {
        glColor4ub(0,255,0,255);
    } else if ([spriteFrameName isEqualToString:@"CYAN"]) {
        glColor4ub(0,255,255,255);
    } else if ([spriteFrameName isEqualToString:@"YELLOW"]) {
        glColor4ub(255,255,0,255);
    } else {
        glColor4ub(255,255,255,255);
    }
}
@end

@implementation SpriteRepresentation

- (id) init {
    
    if (( self = [super init] )) {
        
        [self setup];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) spriteRepresentation {
    return [[[SpriteRepresentation alloc] init] autorelease];
}
- (void) setup {
    position = CGPointMake(0.0, 0.0);
    scale = 5.0;
    rotation = 1.0;
    [self setSpriteFrame:@"BLUE"];
}
- (void) dealloc {
    [super dealloc];
}

- (void) draw {
    
    [self updateColor];
    glPointSize(roundf(scale));
    ccDrawPoint(position);
    //NSLog(@"[DOT size=%2.0f] at %@", scale, NSStringFromCGPoint(position));
}


- (void) setSpriteFrame:(NSString *) sfn {
    spriteFrameName = nil;
    spriteFrameName = [sfn retain];
}
- (void) setPosition:(CGPoint) p {
    position = p;
}
- (void) setRotation:(float)r {
    rotation = r;
}
- (void) setScale:(float)s {
    scale = s;
}
- (void) setZIndex:(float)z {
    self.vertexZ = z;
}

@end
