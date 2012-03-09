//
//  Spawnable.h
//  physics
//
//  Created by Kevin Jenkins on 12/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@protocol Spawnable <NSObject> 

- (void) spawnAt:(CGPoint) p;
- (void) reclaim;
- (bool) canBeHit;

@end
