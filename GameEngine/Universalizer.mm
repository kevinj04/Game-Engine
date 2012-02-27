//
//  Universalizer.m
//  GameEngine
//
//  Created by Kevin Jenkins on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define kOffsetIPadX 0.0 // 64?
#define kOffsetIPadY 0.0 // 32?

#import "Universalizer.h"

@implementation Universalizer

+ (CGPoint) scalePointFromIPad:(CGPoint) p {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return CGPointMake((p.x - kOffsetIPadX) *0.5, (p.y - kOffsetIPadY)*0.5);
    } else {
        return p;
    }
}
+ (CGPoint) scalePointForIPad:(CGPoint) p {
    // ipad actions need to be twice as large, maybe old iphone too?
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return CGPointMake(p.x*2.0+kOffsetIPadX, p.y*2.0+kOffsetIPadY);
    } else {
        return p;
    }
}

+ (CGSize) scaleSizeFromIPad:(CGSize) s {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return CGSizeMake(s.width*0.5, s.height*0.5);
    } else {
        return s;
    }
}
+ (CGSize) scaleSizeForIPad:(CGSize) s {
    // ipad actions need to be twice as large, maybe old iphone too?
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return CGSizeMake(s.width*2.0, s.height*2.0);
    } else {
        return s;
    }
}

+ (CGRect) scaleRectFromIPad:(CGRect) r {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return CGRectMake((r.origin.x - kOffsetIPadX)*0.5, (r.origin.y-kOffsetIPadY)*0.5, r.size.width*0.5, r.size.height*0.5);
    } else {
        return r;
    }
}
+ (CGRect) scaleRectForIPad:(CGRect) r {
    // ipad actions need to be twice as large, maybe old iphone too?
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return CGRectMake(r.origin.x*2.0+kOffsetIPadX, r.origin.y*2.0+kOffsetIPadY, r.size.width*2.0, r.size.height*2.0);
    } else {
        return r;
    }
}

@end
