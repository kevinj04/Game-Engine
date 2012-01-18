//
//  BackgroundTile.m
//  GameEngine
//
//  Created by Kevin Jenkins on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BackgroundTile.h"

NSString *const paramImage = @"image";

@interface BackgroundTile (hidden)
- (void) spriteFinishedLoading:(NSNotification *) notification;
@end
@implementation BackgroundTile (hidden)
- (void) spriteFinishedLoading:(NSNotification *) notification {
    bgSprite = [notification object];
    [bgSprite setAnchorPoint:ccp(0,0)];
    [bgSprite setPosition:[self position]];
    [bgSprite setVisible:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

@implementation BackgroundTile

@synthesize imageFileName;

- (id) initWithDictionary:(NSDictionary *) dictionary {
    
    if (( self = [super init] )) {
        
        [self setupWithDictionary:dictionary];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) tileWithDictionary:(NSDictionary *) dictionary {
    return [[[BackgroundTile alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    [super setupWithDictionary:dictionary];
    
    NSDictionary *params = [dictionary objectForKey:parameters];
    
    if ([params objectForKey:paramImage] != nil) {
        imageFileName = [[params objectForKey:paramImage] retain];
    } else {
        NSAssert(NO, @"Failed to load an image for this background object.");
    }
    
    
    self.vertexZ = 0.0;        
    
    // need to load the sprite here!
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(spriteFinishedLoading:) name:imageFileName object:nil];    
    
    
}
- (void) dealloc {
    
    if (imageFileName != nil) { [imageFileName release]; imageFileName = nil; }
    
    [super dealloc];
    
}

- (void) update:(ccTime) dt {
    
    [super update:dt];
    
}

- (CGRect) boundingBox {
    if (bgSprite != nil) {
        return [bgSprite boundingBox];
    } else {
        return CGRectMake(0.0, 0.0, 0.0, 0.0);
    }
}

@end
