//
//  KJCamera.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJCommonGameObject.h"

@interface KJCamera : KJCommonGameObject

+ (id) camera;
+ (id) cameraWithDictionary:(NSDictionary *) dictionary;

@end
