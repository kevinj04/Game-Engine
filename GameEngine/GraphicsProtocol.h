//
//  GraphicsProtocol.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GraphicsProtocol <NSObject>

- (void) setPosition:(CGPoint) p;
- (void) setRotation:(float) r;
- (void) setSpriteFrame:(NSString *) spriteFrameName;
- (void) setScale:(float) s;

@end
