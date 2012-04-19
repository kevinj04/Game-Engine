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

@synthesize shouldIgnoreBoundingBoxCalculation;

- (id) initWithNode:(CCNode *) n {
    
    if (( self = [super init] )) {
        
        root = [n retain];
        
        graphicBoundingBox = [root boundingBox];
        graphicOffset = ccp(0.0,0.0); // could be weird
        shouldIgnoreBoundingBoxCalculation = NO;
        
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


- (NSString *) objectName {
    return objectName;
}

- (void) setObjectName:(NSString *) n {
    if (objectName) {[objectName release];} 
    objectName = nil;
    objectName = [n retain];
}

- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *)updateObj {
    // override me
}
- (CGPoint) frameOffset {
    
    if ([root isKindOfClass:[CCSprite class]]) {
        
        return [Universalizer scalePointFromIPad:[[(CCSprite *)root displayedFrame] offsetInPixels]];
        
        // the above when changed to the branch gets the menu broken up?
        
        
    } else {
        return ccp(0.0,0.0);
    }
}

- (void) setVisible:(BOOL)v {
    [root setVisible:v];
}

- (CGSize) spriteFrameSize {
    
    // this may cause problems since not all Graphic Elements have a sprite root
    
    
    if ([root isKindOfClass:[CCSprite class]]) {
        
        CGSize originalFrameSize = [[(CCSprite *)root displayedFrame] originalSizeInPixels];
        return originalFrameSize;        
        
    } else {
        return CGSizeMake(0.0, 0.0);
    }
}

- (CGRect) graphicBoundingBox {
    return graphicBoundingBox;
}
- (CGPoint) graphicOffset {
    return graphicOffset;
}

@end
