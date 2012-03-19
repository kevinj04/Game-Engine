//
//  CocosGraphicElement.m
//  GameEngine
//
//  Created by Kevin Jenkins on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CocosGraphicElement.h"

@implementation CocosGraphicElement

- (CCNode *) rootNode {
    return self;
}
- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *)updateObj {
    // override me
}
- (CGPoint) frameOffset {
    
    if ([self isKindOfClass:[CCSprite class]]) {
        
        return [[(CCSprite *)self displayedFrame] offsetInPixels];
        
    } else {
        return ccp(0.0,0.0);
    }
}

@end
