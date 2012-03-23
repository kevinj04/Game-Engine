//
//  CocosGraphicElement.m
//  GameEngine
//
//  Created by Kevin Jenkins on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CocosGraphicElement.h"
#import "Universalizer.h"

@implementation CocosGraphicElement

- (id) initWithNode:(CCNode *) n {
    
    if (( self = [super init] )) {
        
        root = [n retain];
        return self;
    } else {
        return nil;
    }
}
+ (id) nodeWithNode:(CCNode *) n {
    return [[[CocosGraphicElement alloc] initWithNode:n] autorelease];
}
- (void) dealloc {
    [root removeFromParentAndCleanup:YES];
    [root release];
    [super dealloc];
}
- (CCNode *) rootNode {
    return root;
}
- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *)updateObj {
    // override me
}
- (CGPoint) frameOffset {
    
    if ([root isKindOfClass:[CCSprite class]]) {
        
        return [Universalizer scalePointFromIPad:[[(CCSprite *)root displayedFrame] offsetInPixels]];
        
    } else {
        return ccp(0.0,0.0);
    }
}

- (void) setVisible:(BOOL)v {
    [root setVisible:v];
}

@end
