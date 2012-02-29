//
//  CocosGraphicalGameElement.m
//  TestGame
//
//  Created by Kevin Jenkins on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CocosGraphicalGameElement.h"
#import "CocosSpriteRepresentation.h"
#import "SpritePart.h"

@implementation CocosGraphicalGameElement

- (id) initWithDictionary:(NSDictionary *) dictionary andAnimationDictionary:(NSDictionary *) animationDictionary {
    
    if (( self = [super initWithDictionary:dictionary] )) {
        
        [self setupWithDictionary:dictionary andAnimationDictionary:animationDictionary];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) graphicalGameElementWithDictionary:(NSDictionary *) dictionary andAnimationDictionary:(NSDictionary *) animationDictionary {
    return [[[CocosGraphicalGameElement alloc] initWithDictionary:dictionary andAnimationDictionary:animationDictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *)dictionary andAnimationDictionary:(NSDictionary *) animationDictionary {
    
    [super setupWithDictionary:dictionary];
    
    NSDictionary *animationEntry = [animationDictionary objectForKey:[self objectId]];
    
    graphics = [[SpriteObject objectWithDictionary:animationEntry] retain];
    
    if (animationEntry != nil) {
        
        NSDictionary *partsDictionary = [animationEntry objectForKey:spriteObjectParts];    
        
        for (NSString *partName in [partsDictionary allKeys]) {
            
            NSDictionary *animForPartDictionary = [partsDictionary objectForKey:partName];
            
            CocosSpriteRepresentation *rep = [CocosSpriteRepresentation spriteRepresentationWithDictionary:animForPartDictionary];
            
            [graphics setSpriteRep:rep forPart:partName];
            
        }
        
    }
}
- (void) dealloc {
    
    if (graphics != nil) { [graphics release]; graphics = nil; }
    
    [super dealloc];
}

- (void) update:(double) dt {
    
    [super update:dt];
    
    [self setPosition:ccp([self position].x, [self position].y)];
    
    [graphics setPosition:[self position]];
    [graphics setRotation:[self rotation]];
    [graphics setScaleX:[self scaleX]];
    [graphics setScaleY:[self scaleY]];
    
}

- (void) attachToLayer:(CCLayer *) layer {
    for (SpritePart *part in [[graphics parts] allValues]) {
        [layer addChild:(CCSprite *)[part spriteRep] z:0];
    }
}
- (void) runAnimation:(NSString *) animationName {
    [graphics runAnimation:animationName];
}
- (void) runAnimation:(NSString *)animationName onPart:(NSString *)partName {
    [graphics runAnimation:animationName onPart:partName];
}
- (void) setAnimationSpeed:(double) animSpeed {
    [graphics setAnimationSpeed:animSpeed];
}

@end
