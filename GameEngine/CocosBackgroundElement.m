//
//  CocosBackgroundElement.m
//  TestGame
//
//  Created by Kevin Jenkins on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CocosBackgroundElement.h"
#import "SpriteObject.h"
#import "SpritePart.h"
#import "CocosSpriteRepresentation.h"
#import "CocosBGSpriteRepresentation.h"

@implementation CocosBackgroundElement

- (id) initWithDictionary:(NSDictionary *)dictionary andAnimationDictionary:(NSDictionary *) animationDictionary {
    
    if (( self = [super initWithDictionary:dictionary] )) {
        
        [self setupWithDictionary:dictionary andAnimationDictionary:animationDictionary];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) backgroundElementWithDictionary:(NSDictionary *) dictionary andAnimationDictionary:(NSDictionary *) animationDictionary {
    return [[[CocosBackgroundElement alloc] initWithDictionary:dictionary andAnimationDictionary:animationDictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *)dictionary andAnimationDictionary:(NSDictionary *)animationDictionary {
    
    [super setupWithDictionary:dictionary];
    
    NSDictionary *animationEntry = [animationDictionary objectForKey:[self objectId]];
    
    graphics = [[SpriteBGObject objectWithDictionary:animationEntry] retain];
    
    CocosBGSpriteRepresentation *bgSpriteRep = [CocosBGSpriteRepresentation spriteRepresentationWithDictionary:dictionary];
    [graphics setBackgroundSprite:bgSpriteRep];
    
    
    // handles animation capable objects that may be part of the background
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

- (void) update:(double)dt {
    
    [super update:dt];
    
    [graphics setPosition:[self position]];
    
    [graphics update:dt];
    
    // These may become valid commands in later versions
    //[graphics setRotation:[self rotation]];
    //[graphics setScale:[self scale]];
    
    
}

- (void) attachToLayer:(CCLayer *) layer {
    
    CCSprite *bgSprite = (CCSprite *)[graphics bgSprite];
    
    [layer addChild:bgSprite z:0];
    
    for (SpritePart *part in [[graphics parts] allValues]) {
        [bgSprite addChild:(CCSprite *)[part spriteRep] z:1];
    }    
}

@end
