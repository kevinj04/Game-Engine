//
//  CocosComplexSpriteElement.m
//  TestGame
//
//  Created by Kevin Jenkins on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CocosComplexSpriteElement.h"
#import "SpritePart.h"
#import "SpriteUpdateProtocol.h"

NSString *const zOrderStr = @"zIndex";

@interface CocosComplexSpriteElement (hidden)
- (void) updateBatchNodeWithInfo:(NSObject<SpriteUpdateProtocol> *) p;
- (void) updateSpritePart:(SpritePart *) part;
@end

@implementation CocosComplexSpriteElement (hidden)
- (void) updateBatchNodeWithInfo:(NSObject<SpriteUpdateProtocol> *) p {
    [batchNode setPosition:[p position]]; 
    [batchNode setRotation:[p rotation]];
    
    [batchNode setScaleX:[p scaleX]];
    [batchNode setScaleY:[p scaleY]];
    
    [batchNode setVertexZ:[p vertexZ]];
    [batchNode setZOrder:[p zOrder]]; // maybe slow?
    [batchNode setVisible:[p visible]];
    
    [batchNode setAnchorPoint:[p anchorPoint]];
}
- (void) updateSpritePart:(NSObject<SpriteUpdateProtocol> *) part {
    
    CocosGraphicElement *cge = [sprites objectForKey:[part name]];
    
    if (cge == nil) { return; }
    
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[part spriteFrameName]];
    
    CCSprite *s;
    if (![[cge rootNode] isKindOfClass:[CCSprite class]]) { return; } else {
        s = (CCSprite *)[cge rootNode];
    }
    
    if (frame != [s displayedFrame]) {
        [s setDisplayFrame:frame];
    }
    
    
    [s setPosition:[part position]];
    [s setRotation:[part rotation]];
    
    [s setScaleX:[part scaleX]];
    [s setScaleY:[part scaleY]];
    
    [s setVertexZ:[part vertexZ]];
    [s setZOrder:[part zOrder]]; // maybe slow?
    [s setVisible:[part visible]];
    
    [s setFlipX:[part flipX]];
    [s setFlipY:[part flipY]];
    
    [s setAnchorPoint:[part anchorPoint]];
    
}
@end

@implementation CocosComplexSpriteElement

- (id) initWithSpriteInfo:(SpriteObject *) sObj {
    
    if (( self = [super initWithNode:[CCNode node]] )) {        
        [self setupWithSpriteInfo:sObj];
        return self;
    } else {
        return nil;
    }
}
+ (id) spriteElementWithSpriteInfo:(SpriteObject *) sObj {
    return [[[CocosComplexSpriteElement alloc] initWithSpriteInfo:sObj] autorelease];
}
- (void) setupWithSpriteInfo:(SpriteObject *) sObj {
    
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithCapacity:[[[sObj parts] allValues] count]];    
    for (SpritePart *part in [[sObj parts] allValues]) {
        
        CocosGraphicElement *cge = [CocosGraphicElement nodeWithNode:[CCSprite node]];
        [temp setObject:cge forKey:[part name]];
    }
    sprites = [temp retain];
    
    for (SpritePart *part in [[sObj parts] allValues]) {                
        
        [self updateSpritePart:part];
        
        CocosGraphicElement *cge = [sprites objectForKey:[part name]];
        CCSprite *s = (CCSprite *)[cge rootNode];
        
        if (batchNode == nil) {
            
            CCTexture2D *tx = [[s displayedFrame] texture] ;            
            batchNode = [[CCSpriteBatchNode alloc] initWithTexture:tx capacity:[[[sObj parts] allValues] count]];            
        }
        
        int zOrder;
        if (batchNode != nil) {         
            // todo: handle z-indexing
            zOrder = (int)([part vertexZ] * 100);
            [batchNode addChild:s z:zOrder];
            [s setUsesBatchNode:YES];
            [s setBatchNode:batchNode];
            [s setVertexZ:[sObj vertexZ] + [part vertexZ]];
        }
        
        [part setSpriteRep:cge];
        
    }
    
    // if batchNode is nil, then we have a graphicless object... this is ok.
    if (batchNode != nil) {
        [root addChild:batchNode z:0];
    }
    
    
}
- (void) dealloc {
    NSLog(@"Releasing BatchNode[%@]: %@", batchNode, [batchNode texture]);
    //if (batchNode != nil) { [batchNode release]; batchNode = nil; }
    [super dealloc];
}

- (void) update:(double)dt {
    // this is really not necessary?
}
- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *)updateObj {
    
    SpriteObject *sObj = (SpriteObject *)updateObj; // must be true for this to run properly
    
    [self updateBatchNodeWithInfo:sObj];
    
    for (SpritePart *part in [[sObj parts] allValues]) {
        
        [self updateSpritePart:part];
        
    }        
    
}
- (void) setVisible:(BOOL)v {
    [batchNode setVisible:v];
}

- (void) attachToLayer:(CCLayer *) layer {
    [layer addChild:root z:[batchNode zOrder]];
}


@end
