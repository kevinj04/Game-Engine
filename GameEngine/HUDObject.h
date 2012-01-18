//
//  HUDObject.h
//  GameEngine
//
//  Created by Kevin Jenkins on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhysicsObject.h"

@interface HUDObject : PhysicsObject {
    
}

- (id) initWithDictionary:(NSDictionary *)dictionary;
+ (id) objectWithDictionary:(NSDictionary *)dictionary;
- (void) setupWithDictionary:(NSDictionary *)dictionary;
- (void) dealloc;

- (void) update:(ccTime)dt;

@end
