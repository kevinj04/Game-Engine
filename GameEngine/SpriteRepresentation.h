//
//  SpriteRepresentation.h
//  TestGame
//
//  Created by Kevin Jenkins on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphicsProtocol.h"
#import "cocos2d.h"

@interface SpriteRepresentation : CCNode<GraphicsProtocol> {
    
    @private
    NSString *spriteFrameName;
    CGPoint position;
    float rotation;
    float scale;
    bool flipX;
    bool flipY;
    
}

- (id) init;
+ (id) spriteRepresentation;
- (void) setup;
- (void) dealloc;

- (void) draw;


@end
