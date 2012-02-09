//
//  GameElementProtocol.h
//  GameEngine
//
//  Created by Kevin Jenkins on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Spawnable.h"
#import "GameElement.h"

@protocol GameElementProtocol <NSObject, Spawnable>

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (id) elementWithDictionary:(NSDictionary *) dictionary;

- (void) update:(double) dt;

- (NSMutableDictionary *) dictionary;
- (void) resetWithDictionary:(NSDictionary *) dictionary;

- (bool) isActive;
- (void) setActive:(bool) b;

- (NSString *) objectName;
- (void) setObjectName:(NSString *) objName;
- (NSString *) objectId;
- (void) setObjectId:(NSString *) objId;
- (elementType) objectType;
- (void) setObjectType:(elementType) t;

@end
