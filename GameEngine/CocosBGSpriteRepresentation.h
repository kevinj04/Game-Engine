//
//  CocosBGSpriteRepresentation.h
//  TestGame
//
//  Created by Kevin Jenkins on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GraphicsProtocol.h"

@interface CocosBGSpriteRepresentation : CCSprite<GraphicsProtocol> {
    
    @private
    NSString *backgroundFileName;
}

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) spriteRepresentationWithDictionary:(NSDictionary *) dictionary;
- (void) setupWithDictionary:(NSDictionary *) dictionary;
- (void) dealloc;

- (void) draw;
- (NSString *) backgroundFileName;


@end
