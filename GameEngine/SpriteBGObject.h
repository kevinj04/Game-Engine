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
    
    @private
    NSObject<GraphicsProtocol> *bgSprite;
}

- (void) setBackgroundSprite:(NSObject<GraphicsProtocol> *) newBGSprite;



@end
