//
//  KJGraphical.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKIt.h>

@protocol KJGraphical <NSObject>

- (NSString *) objectName;

- (CGPoint) position;
- (float) rotation;
- (CGPoint) anchorPoint;
- (CGRect) boundingBox;

- (float) scaleX;
- (float) scaleY;

- (double) animationSpeed;

- (float) vertexZ;
- (int) zOrder;



- (bool) visible;

- (bool) flipX;
- (bool) flipY;

- (bool) shouldIgnoreBatchNodeUpdate;

@end
