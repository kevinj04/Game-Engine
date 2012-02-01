//
//  SpriteBGObject.m
//  GameEngine
//
//  Created by Kevin Jenkins on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpriteBGObject.h"

@implementation SpriteBGObject

- (id) initWithDictionary:(NSDictionary *) dictionary {
 
    if (( self = [super initWithDictionary:dictionary] )) {
        
        [self setupWithDictionary:dictionary];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) objectWithDictionary:(NSDictionary *) dictionary {
    return [[[SpriteBGObject alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    
    [super setupWithDictionary:dictionary];
    
    
    
}
- (void) dealloc {
    
    if (bgSprite != nil) { [bgSprite release]; bgSprite = nil; }
    
    [super dealloc];
    
}

- (void) update:(double) dt {
    [super update:dt];
    
    // update sprite position -- maybe someday with camera offset?
    [bgSprite setPosition:[self position]];
}

- (void) runAnimation:(NSString *) animationName onPart:(NSString *) partName {
    [super runAnimation:animationName onPart:partName];
}
- (void) runAnimation:(NSString *) animationName {
    [super runAnimation:animationName];
}

- (void) setSpriteRep:(NSObject<GraphicsProtocol> *) rep forPart:(NSString *) partName {
    [super setSpriteRep:rep forPart:partName];
}
- (NSDictionary *) parts {
    return [super parts];
}


- (void) setBackgroundSprite:(NSObject<GraphicsProtocol> *) newBGSprite {
    
    if (bgSprite != nil) { [bgSprite release]; bgSprite = nil; };
    bgSprite = [newBGSprite retain];
    
    [bgSprite setPosition:[self position]];
    
}
- (NSObject<GraphicsProtocol> *) bgSprite {
    return bgSprite;
}

- (void) setPosition:(CGPoint) p {
    [bgSprite setPosition:p];
    [super setPosition:p];
}
- (CGPoint) position {
    // this may be an issue!
    return CGPointMake(0.0,0.0);
}

@end
