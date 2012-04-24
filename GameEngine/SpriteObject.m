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
NSString *const spriteVertexZ = @"vertexZ";
NSString *const spriteZOrder = @"zOrder";
NSString *const spriteBody = @"spriteBody";
NSString *const spriteShouldIgnoreBatchNodeUpdate = @"ignoreBatchNodeUpdate";;

@interface SpriteObject (hidden)
- (CGPoint) calculateOffset;
@end

@implementation SpriteObject (hidden)
- (CGPoint) calculateOffset {
    
    if ([primarySprite isEqualToString:[NSString stringWithFormat:@""]]) return CGPointMake(0.0, 0.0);
    
    return [[parts objectForKey:primarySprite] frameOffset];
    
}
@end

@implementation SpriteObject

@synthesize objectName, position, rotation, scaleX, scaleY, animationSpeed, vertexZ, zOrder, anchorPoint, boundingBox, visible, flipX, flipY, shouldIgnoreBatchNodeUpdate;

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
    
    position = CGPointMake(0.0, 0.0);
    scaleX = 1.0;
    scaleY = 1.0;
    rotation = 0.0;
    animationSpeed = 1.0;   
    vertexZ = 0.0;
    zOrder = 0;
    anchorPoint = CGPointMake(0.5,0.5);
    boundingBox = CGRectMake(0.0, 0.0, 10.0, 10.0);   
    visible = YES;
    flipX = NO;
    flipY = NO;
    
    primarySprite = [[NSString stringWithFormat:@""] retain];
    
    if ([dictionary objectForKey:spriteVertexZ] != nil) {
        vertexZ = [[dictionary objectForKey:spriteVertexZ] floatValue];
    }
    
    if ([dictionary objectForKey:spriteZOrder] != nil) {
        zOrder = [[dictionary objectForKey:spriteZOrder] intValue];
    }
    
    if ([dictionary objectForKey:spriteBody] != nil) {
        primarySprite = [[dictionary objectForKey:spriteBody] retain];
    }
    
    shouldIgnoreBatchNodeUpdate = NO;
    if ([dictionary objectForKey:spriteShouldIgnoreBatchNodeUpdate] != nil) {
        shouldIgnoreBatchNodeUpdate = [[dictionary objectForKey:spriteShouldIgnoreBatchNodeUpdate] boolValue];
    }
    
    
    if ([dictionary objectForKey:spriteObjectParts] != nil) {
        
        NSDictionary *partsDictionary = [dictionary objectForKey:spriteObjectParts];
        
        NSMutableDictionary *tempParts = [NSMutableDictionary dictionaryWithCapacity:[partsDictionary count]];
        
        for (NSString *partName in [partsDictionary allKeys]) {
            
            SpritePart *part = [SpritePart partWithDictionary:[partsDictionary objectForKey:partName]];
            [part setParent:self];
            [part setObjectName:partName];
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
    
    dt = dt * animationSpeed;
    
    for (SpritePart *part in [parts allValues]) {
        [part update:dt];
    }
    
}

- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *) pObj {
    
    [self setPosition:[pObj position]];
    [self setRotation:[pObj rotation]];
    
    [self setAnchorPoint:[pObj anchorPoint]];
    
    [self setScaleX:[pObj scaleX]];
    [self setScaleY:[pObj scaleY]];
    
    [self setVertexZ:[pObj vertexZ]];
    [self setZOrder:[pObj zOrder]];
    
    [self setBoundingBox:[pObj boundingBox]];
    
    [self setFlipX:[pObj flipX]];
    [self setFlipY:[pObj flipY]];
    
    for (SpritePart *part in [parts allValues]) {
        [part updateWithPhysicsInfo:self];
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

- (void) setPosition:(CGPoint) p forPart:(NSString *) partName {
    
    if ([parts objectForKey:partName] == nil) return;
    
    [[parts objectForKey:partName] setMasterPosition:p];
}
- (void) setFlipX:(bool) b forPart:(NSString *) partName {
    
    if ([parts objectForKey:partName] == nil) return;
    
    [[parts objectForKey:partName] setMasterFlipX:b];
}
- (void) setFlipY:(bool) b forPart:(NSString *) partName {
    
    if ([parts objectForKey:partName] == nil) return;
    
    [[parts objectForKey:partName] setMasterFlipY:b];
}

- (void) setRotation:(float)r forPart:(NSString *) partName {    
    
    if ([parts objectForKey:partName] == nil) return;
    
    [[parts objectForKey:partName] setMasterRotation:r];
    
}
- (void) setScaleX:(float) f forPart:(NSString *) partName {
    if ([parts objectForKey:partName] == nil) return;
    
    [[parts objectForKey:partName] setMasterScaleX:f];
}
- (void) setScaleY:(float) f forPart:(NSString *) partName {
    if ([parts objectForKey:partName] == nil) return;
    
    [[parts objectForKey:partName] setMasterScaleY:f];
}

- (NSDictionary *) parts {
    return parts;
}

- (CGPoint) childBasePosition {
    return position;
}

- (NSString *) spriteFrameName {
    // this protocol method is ignored as sprites are parts
    return nil;
}

- (CGPoint) frameOffset {
    
    return [self calculateOffset];
    
}


@end
