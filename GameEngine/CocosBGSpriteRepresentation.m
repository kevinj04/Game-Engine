//
//  CocosBGSpriteRepresentation.m
//  TestGame
//
//  Created by Kevin Jenkins on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CocosBGSpriteRepresentation.h"
#import "SpritePart.h"
#import "BackgroundTile.h"

@interface CocosBGSpriteRepresentation (hidden)
- (void) spriteFinishedLoading:(CCTexture2D *) tx;
@end

@implementation CocosBGSpriteRepresentation (hidden)
- (void) spriteFinishedLoading:(CCTexture2D *) tx {        
    
    CGSize s = [tx contentSize];
    
    [self setTexture:tx];
    [self setTextureRect:CGRectMake(0, 0, s.width, s.height)];
    [self setAnchorPoint:ccp(0.5,0.5)];
    [self setVisible:YES];
}
@end

@implementation CocosBGSpriteRepresentation

- (id) initWithDictionary:(NSDictionary *) dictionary {
    
    if (( self = [super init] )) {
        
        [self setupWithDictionary:dictionary];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) spriteRepresentationWithDictionary:(NSDictionary *) dictionary {
    return [[[CocosBGSpriteRepresentation alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    if ([[dictionary objectForKey:parameters] objectForKey:paramPosition] != nil) {
        backgroundFileName = [[dictionary objectForKey:parameters] objectForKey:paramImage];
    } else {
        backgroundFileName = nil;
    }
     
    [self setSpriteFrame:backgroundFileName];
    
}
- (void) dealloc {
    
    if (backgroundFileName != nil) { [backgroundFileName release]; backgroundFileName = nil; }
    
    [super dealloc];
    
}

- (void) draw {
    [super draw];    
}
- (NSString *) backgroundFileName {
    return backgroundFileName;
}


- (void) setSpriteFrame:(NSString *) sfn {
    backgroundFileName = nil;
    backgroundFileName = [sfn retain];
    
    if (sfn == nil) { return; }
    
    CCTextureCache *cache = [CCTextureCache sharedTextureCache];
    
    CCTexture2D *tx = [cache textureForKey:backgroundFileName];
    
    if (tx == nil) {
        [super setVisible:NO];
        [super setTexture:nil];
        [cache addImageAsync:backgroundFileName target:self selector:@selector(spriteFinishedLoading:)];
    } else {
        [super setTexture:tx];
    }        
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
- (void) setZIndex:(float)z {
    self.vertexZ = z;
}



@end
