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
    
    CocosGraphicElement *cge = [sprites objectForKey:[part objectName]];
    
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
    
    int zOrder = (int)([part vertexZ] * 100);
    float vz  = [[(SpritePart *)part parent]  vertexZ] + [part vertexZ];

    
    [s setVertexZ:vz];
    [s setZOrder:zOrder]; // maybe slow?
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
        [cge setObjectName:[part objectName]];
        [temp setObject:cge forKey:[part objectName]];
        [cge setShouldIgnoreBoundingBoxCalculation:[part shouldIgnoreBoundingBox]];
    }
    sprites = [temp retain];
    
    for (SpritePart *part in [[sObj parts] allValues]) {                
        
        [self updateSpritePart:part];
        
        CocosGraphicElement *cge = [sprites objectForKey:[part objectName]];
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
            //NSLog(@"Attaching sprite %@  with vertexZ:%2.2f and zOrder: %i", [part name], [s vertexZ], [s zOrder]);
        }
        
        [part setSpriteRep:cge];
        
    }
    
    // if batchNode is nil, then we have a graphicless object... this is ok.
    if (batchNode != nil) {
        [root addChild:batchNode z:0];
    }
    
    [self updateComplexBoundingBox];
    
}
- (void) dealloc {
    //NSLog(@"Releasing BatchNode[%@]: %@", batchNode, [batchNode texture]);
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

- (void) updateComplexBoundingBox {
    
    
    graphicBoundingBox.size = CGSizeMake(0.0, 0.0);
    graphicBoundingBox.origin = ccp(0.0,0.0);
    
    for (CocosGraphicElement *cge in [sprites allValues]) {
        
        
        // CHECK THIS !!!
        
        if (![cge shouldIgnoreBoundingBoxCalculation]) {
            
            CCSpriteFrame *frame = [(CCSprite *)[cge rootNode] displayedFrame];
            CGRect fixedRect = CGRectMake(frame.rect.origin.x, frame.rect.origin.y, 
                                          frame.rect.size.width, frame.rect.size.height);
            
            fixedRect.origin =  ccp([frame offsetInPixels].x/CC_CONTENT_SCALE_FACTOR(), [frame offsetInPixels].y/CC_CONTENT_SCALE_FACTOR());
            if ([frame rotated]) {
                float height = fixedRect.size.height;
                fixedRect.size.height = fixedRect.size.width;
                fixedRect.size.width = height;
            }
        
            
            if (graphicBoundingBox.size.width == 0) {
                graphicBoundingBox = fixedRect;
            } else {
                graphicBoundingBox = CGRectUnion(graphicBoundingBox, fixedRect);                
            }
            //NSLog(@"Part[%@] has bounding box: %@", [cge objectName], NSStringFromCGRect(fixedRect));
        }
    }
    
    //CGSize spriteSize  = complexBoundingBox.size; 
    
    CGSize batchNodeSize = [batchNode contentSize];
    CGPoint batchNodeAnchorPosition = ccp([batchNode anchorPoint].x*batchNodeSize.width, [batchNode anchorPoint].y*batchNodeSize.height);
    
    CGPoint complexBoundingBoxAPPosition = ccp([batchNode anchorPoint].x*graphicBoundingBox.size.width, [batchNode anchorPoint].y*graphicBoundingBox.size.height);
    
    graphicOffset = ccpSub(complexBoundingBoxAPPosition, batchNodeAnchorPosition);
    
    //NSLog(@"[%@] Final Complex Bounding Box: %@", self, NSStringFromCGRect(myBoundingBox));
    
}


- (void) setVisible:(BOOL)v {
    [batchNode setVisible:v];
}

- (void) attachToLayer:(CCLayer *) layer {
    [layer addChild:root z:[batchNode zOrder]];
}

- (CCSpriteBatchNode *) batchNode {
    return batchNode;
}
- (void) setBatchNode:(CCSpriteBatchNode *) sbn {
    if (batchNode != nil) { [batchNode removeFromParentAndCleanup:YES]; batchNode = nil; }
    
    batchNode = [sbn retain];

    for (CocosGraphicElement *cge in [sprites allValues]) {
        
        CCSprite *s = (CCSprite *)[cge rootNode];
        
        [s removeFromParentAndCleanup:YES];
        
        [batchNode addChild:s z:[s zOrder]];
        [s setUsesBatchNode:YES];
        [s setBatchNode:batchNode];
        
    }
    
}
    
@end
