//
//  KJCocosGraphicObject.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJCocosGraphicObject.h"
#import "Universalizer.h"

@implementation KJCocosGraphicObject

@synthesize shouldIgnoreBoundingBoxCalculation;

- (id) initWithNode:(CCNode *) n {
    
    if (( self = [super init] )) {
        
        rootNode = [n retain];
        
        graphicBoundingBox = [rootNode boundingBox];
        graphicOffset = ccp(0.0,0.0); // could be weird
        shouldIgnoreBoundingBoxCalculation = NO;
        
        return self;
    } else {
        return nil;
    }
}
+ (id) nodeWithNode:(CCNode *) n {
    return [[[KJCocosGraphicObject alloc] initWithNode:n] autorelease];
}
- (void) dealloc {
    [rootNode removeFromParentAndCleanup:YES];
    [rootNode release];
    [super dealloc];
}
- (CCNode *) rootNode {
    return rootNode;
}


- (NSString *) objectName {
    return objectName;
}

- (void) setObjectName:(NSString *) n {
    if (objectName) {[objectName release];} 
    objectName = nil;
    objectName = [n retain];
}

- (void) updateWithGraphical:(NSObject<KJGraphical> *) updateObject {
    // override me
    
}
- (CGPoint) frameOffset {
    
    if ([rootNode isKindOfClass:[CCSprite class]]) {
        
        return [Universalizer scalePointFromIPad:[[(CCSprite *)rootNode displayedFrame] offsetInPixels]];
        
        // the above when changed to the branch gets the menu broken up?
        
        
    } else {
        return ccp(0.0,0.0);
    }
}

- (CGSize) spriteFrameSize {
    
    // this may cause problems since not all Graphic Elements have a sprite root
    
    
    if ([rootNode isKindOfClass:[CCSprite class]]) {
        
        CGSize originalFrameSize = [[(CCSprite *)rootNode displayedFrame] originalSizeInPixels];
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
