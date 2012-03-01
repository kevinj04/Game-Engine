//
//  StackElementProtocol.h
//  GameEngine
//
//  Created by Kevin Jenkins on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol StackElementProtocol <NSObject>

- (CGRect) boundingBox;
- (CGPoint) position;
- (void) setActive:(bool) b;
- (bool) isActive;
- (void) update:(double) dt;

@end
