//
//  Universalizer.h
//  GameEngine
//
//  Created by Kevin Jenkins on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Universalizer : NSObject {
    
}

/** @brief Returns a device independent distance value for computing speeds. */
+ (CGPoint) scalePointFromIPad:(CGPoint) p;
/** @brief Returns a device independent point value for animations/actions. */
+ (CGPoint) scalePointForIPad:(CGPoint) p;

/** @brief Returns a device independent distance value for computing speeds. */
+ (CGSize) scaleSizeFromIPad:(CGSize) s;
/** @brief Returns a device independent point value for animations/actions. */
+ (CGSize) scaleSizeForIPad:(CGSize) s;

/** @brief Returns a device independent distance value for computing speeds. */
+ (CGRect) scaleRectFromIPad:(CGRect) r;
/** @brief Returns a device independent point value for animations/actions. */
+ (CGRect) scaleRectForIPad:(CGRect) r;

@end
