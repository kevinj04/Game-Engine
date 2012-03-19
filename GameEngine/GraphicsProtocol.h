//
//  GraphicsProtocol.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SpriteUpdateProtocol.h"

@protocol GraphicsProtocol <NSObject>

- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *) updateObj;
- (void) setVisible:(BOOL) v;
- (CGPoint) frameOffset;
/*
 - (void) setPosition:(CGPoint) p;
 - (void) setRotation:(float) r;
 - (void) setSpriteFrame:(NSString *) spriteFrameName;
 - (void) setScaleX:(float) s;
 - (void) setScaleY:(float) s;
 - (void) setZIndex:(float) z;
 - (void) setFlipX:(bool) fx;
 - (void) setFlipY:(bool) fy;
 - (void) setVisible:(BOOL) v;
 - (void) setAnchorPoint:(CGPoint) ap;
 */

@end
