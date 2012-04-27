//
//  SpawnableZ.h
//  GameEngine
//
//  Created by Kevin Jenkins on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Spawnable.h"

@protocol SpawnableZ <Spawnable>

- (int) zOrder;
- (void) setZOrder:(int) z;
- (float) vertexZ;

@end
