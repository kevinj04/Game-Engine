//
//  SpriteBGObject.h
//  GameEngine
//
//  Created by Kevin Jenkins on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpriteObject.h"

@interface SpriteBGObject : SpriteObject {
    
    NSString *backgroundFileName;
    
}

@property (nonatomic, retain) NSString *backgroundFileName;


@end
