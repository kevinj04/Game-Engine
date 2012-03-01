//
//  BackgroundTile.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpriteBGObject.h"
#import "GameElement.h"

extern NSString *const paramImage;
extern NSString *const paramPosition;

@interface BackgroundTile : GameElement {
    NSString *imageFileName;
    CGPoint position;
    
    SpriteBGObject *graphics;
}

/** The name of the .png image file that corresponds to this background object. */
@property (nonatomic, retain) NSString *imageFileName;

/** The position of the background object. This is NOT a physics object. */
@property CGPoint position;
@property CGRect boundingBox;

@property (nonatomic, retain) SpriteObject *graphics;

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) tileWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

- (void) update:(double) dt;

@end
