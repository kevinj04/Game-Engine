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

- (NSString *) objectName; // the name of the sprite we are updating

- (CGPoint) position;
- (float) rotation;

- (float) scaleX;
- (float) scaleY;

- (float) vertexZ;
- (int) zOrder;

- (CGPoint) anchorPoint;
- (CGRect) boundingBox;
- (NSString *) spriteFrameName;

- (bool) flipX;
- (bool) flipY;

- (bool) visible;

// this is a return value set from the GraphicsProtocol object
- (CGPoint) frameOffset;

- (bool) shouldIgnoreBatchNodeUpdate;

@end
