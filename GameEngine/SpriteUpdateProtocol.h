//
//  SpriteUpdateProtocol.h
//  GameEngine
//
//  Created by Kevin Jenkins on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SpriteUpdateProtocol <NSObject> 

- (CGPoint) position;
- (float) rotation;

- (float) scaleX;
- (float) scaleY;

- (float) vertexZ;
- (int) zOrder;

- (CGPoint) anchorPoint;
- (CGRect) boundingBox;
- (NSString *) spriteFrameName;

- (bool) visible;

@end
