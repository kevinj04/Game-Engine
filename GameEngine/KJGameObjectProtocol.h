//
//  KJGameObjectProtocol.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum kjElementType {
    kjetObject, kjetSpriteObject, kjetCamera, kjetHUD
} kjElementType;

@protocol KJGameObjectProtocol <NSObject>

- (void) update:(double)dt;

- (bool) isActive;
- (void) setIsActive:(bool) b;

- (NSString *) objectName;
- (void) setObjectName:(NSString *) objName;
- (NSString *) objectId;
- (void) setObjectId:(NSString *) objId;
- (kjElementType) objectType;
- (void) setObjectType:(kjElementType) t;

@end
