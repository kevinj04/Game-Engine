//
//  GraphicalGameElement.h
//  TestGame
//
//  Created by Kevin Jenkins on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphicsProtocol.h"
#import "SpriteObject.h"

@interface GraphicalGameElement : NSObject<GraphicsProtocol> {    
    
    CGPoint position;
    float rotation;
    
    float scaleX;
    float scaleY;
    
    float vertexZ;
    float zOrder;
    
    CGPoint anchorPoint;
    CGRect boundingBox;
    
    NSString *spriteFrameName;
    
    bool visible;        
}

@property CGPoint position;
@property float rotation;
@property float scaleX;
@property float scaleY;
@property float vertexZ;
@property float zOrder;
@property CGPoint anchorPoint;
@property CGRect boundingBox;
@property (nonatomic, retain) NSString *spriteFrameName;
@property bool visible;    

- (id) initWithSpriteObject:(SpriteObject *) sObj;
+ (id) elementWithSpriteObject:(SpriteObject *) sObj;
- (void) setupWithSpriteObject:(SpriteObject *) sObj;
- (void) dealloc;

- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *)updateObj;
- (void) draw;


@end
