//
//  CocosGraphicElement.h
//  GameEngine
//
//  Created by Kevin Jenkins on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphicsProtocol.h"
#import "cocos2d.h"

@interface CocosGraphicElement : NSObject<GraphicsProtocol> {
    
    CCNode *root;
    
}

- (id) initWithNode:(CCNode *) n;
+ (id) nodeWithNode:(CCNode *) n;
- (void) dealloc;
- (CCNode *) rootNode;


@end
