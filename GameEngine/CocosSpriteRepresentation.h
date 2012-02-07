//
//  CocosSpriteRepresentation.h
//  TestGame
//
//  Created by Kevin Jenkins on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GraphicsProtocol.h"

@interface CocosSpriteRepresentation : CCSprite<GraphicsProtocol> {
    
    @private
    NSString *spriteFrameName;
    
}

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) spriteRepresentationWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

- (void) draw;
- (NSString *) spriteFrameName;

@end
