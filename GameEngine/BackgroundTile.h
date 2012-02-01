//
//  BackgroundTile.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpriteObject.h"
#import "GameElement.h"

extern NSString *const paramImage;

@interface BackgroundTile : GameElement {
    NSString *imageFileName;
}

/** The name of the .png image file that corresponds to this background object. */
@property (nonatomic, retain) NSString *imageFileName;

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) tileWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

- (void) update:(double) dt;

@end
