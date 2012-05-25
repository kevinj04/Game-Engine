//
//  KJModuleProtocol.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJModuleProtocol.h"
#import "KJCommonGameObject.h"

@protocol KJModuleProtocol <NSObject>

- (KJCommonGameObject *) parent;
- (void) update:(double) dt;

@end
