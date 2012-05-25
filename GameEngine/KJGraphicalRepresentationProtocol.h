//
//  KJGraphicalRepresentationProtocol.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJGraphical.h"

@protocol KJGraphicalRepresentationProtocol <NSObject>

- (void) updateWithGraphical:(NSObject<KJGraphical> *) updateObject;
- (CGPoint) frameOffset;

@end
