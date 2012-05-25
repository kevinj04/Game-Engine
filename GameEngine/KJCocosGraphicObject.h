//
//  KJCocosGraphicObject.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "KJGraphicalRepresentationProtocol.h"

@interface KJCocosGraphicObject : NSObject<KJGraphicalRepresentationProtocol> {
    
    CCNode *rootNode;
    
    CGRect graphicBoundingBox;
    CGPoint graphicOffset;
    NSString *objectName;
    
    bool shouldIgnoreBoundingBoxCalculation;
    
}

@property bool shouldIgnoreBoundingBoxCalculation;

- (id) initWithNode:(CCNode *) n;
+ (id) nodeWithNode:(CCNode *) n;
- (void) dealloc;
- (CCNode *) rootNode;

- (NSString *) objectName;
- (void) setObjectName:(NSString *) n;


/** Useful for determining the current size of an object graphically... we can base bodies on sprites... */
- (CGRect) graphicBoundingBox;
- (CGPoint) graphicOffset;
- (CGSize) spriteFrameSize;


@end
