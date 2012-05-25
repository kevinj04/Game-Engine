//
//  CGExtensions.h
//  GameEngine
//
//  Created by Kevin Jenkins on 12/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#ifndef GameEngine_CGExtensions_h
#define GameEngine_CGExtensions_h

/** Returns a random point inside a given rectangle. Kevin Code!
 @return CGPoint
 */
static inline CGPoint
ccpInRect(const CGRect r)
{
    return CGPointMake(r.origin.x + arc4random() % (int) r.size.width, r.origin.y + arc4random() % (int) r.size.height);
}

#endif
