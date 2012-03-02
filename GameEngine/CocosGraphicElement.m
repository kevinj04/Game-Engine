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
    return nil;
}
- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *)updateObj {
    // override me
}
- (void) setVisible:(BOOL)v {
    if ([self rootNode] != nil) { [[self rootNode] setVisible:v]; }
}

@end
