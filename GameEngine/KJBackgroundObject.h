//
//  KJBackgroundObject.h
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJGraphicalObject.h"

extern NSString *const kjImage;

@interface KJBackgroundObject : KJGraphicalObject {
    
    NSString *backgroundFileName;
    
}

@property (nonatomic, retain) NSString *backgroundFileName;

@end
