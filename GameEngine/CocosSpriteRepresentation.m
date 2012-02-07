//
//  CocosSpriteRepresentation.m
//  TestGame
//
//  Created by Kevin Jenkins on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CocosSpriteRepresentation.h"
#import "SpritePart.h"

@implementation CocosSpriteRepresentation

- (id) initWithDictionary:(NSDictionary *) dictionary {
    
    if (( self = [super init] )) {
        
        [self setupWithDictionary:dictionary];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) spriteRepresentationWithDictionary:(NSDictionary *) dictionary {
    return [[[CocosSpriteRepresentation alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    NSString *currentAnimation = [dictionary objectForKey:partRunningAnimation];
    
    // todo: Make a string constant for default
    if (currentAnimation == nil) { currentAnimation = @"default"; }
    
    NSDictionary *defaultKeyFrame0Dictionary = [[[[dictionary objectForKey:partAnimations] objectForKey:currentAnimation] objectForKey:timeLineKeyFrames] objectAtIndex:0];
    
    if (defaultKeyFrame0Dictionary == nil) {
        NSLog(@"ERROR[CocosSpriteRepresentation]: COULD NOT LOAD DEFAULT/LAST ANIMATION FRAME ZERO for %@", self);
    }
    
    CGPoint kf0Position = CGPointFromString([defaultKeyFrame0Dictionary objectForKey:keyFrameSpritePosition]);
    float kf0Scale = [[defaultKeyFrame0Dictionary objectForKey:keyFrameSpriteScale] floatValue];
    float kf0Rotation = [[defaultKeyFrame0Dictionary objectForKey:keyFrameSpriteRotation] floatValue];
    NSString *kf0SpriteFrameName = [defaultKeyFrame0Dictionary objectForKey:keyFrameSpriteFrame];
    
    [self setPosition:kf0Position];
    [self setScale:kf0Scale];
    [self setRotation:kf0Rotation];
    [self setSpriteFrame:kf0SpriteFrameName];
    
}
- (void) dealloc {
    
    if (spriteFrameName != nil) { [spriteFrameName release]; spriteFrameName = nil; }
    
    [super dealloc];
    
}

- (void) draw {
    [super draw];
}


- (void) setSpriteFrame:(NSString *) sfn {
    spriteFrameName = nil;
    spriteFrameName = [sfn retain];
    
    CCSpriteFrame *sf = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:sfn];
        
    // set the texture
    if (![self usesBatchNode]) {
        CCTexture2D *tx = [sf texture];
        [self setTexture:tx];
    }
    
    [super setDisplayFrame:sf];
    
}
- (void) setPosition:(CGPoint) p {
    [super setPosition:p];
}
- (void) setRotation:(float)r {
    [super setRotation:r];
}
- (void) setScale:(float)s {
    [super setScale:s];    
}

- (NSString *) spriteFrameName {
    return spriteFrameName;
}
- (void) setZIndex:(float)z {
    self.vertexZ = z;
}


@end
