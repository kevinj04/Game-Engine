//
//  KJCocosComplexSpriteObject.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJCocosComplexSpriteObject.h"
#import "KJGraphicsPart.h"

@interface KJCocosComplexSpriteObject (hidden)
- (void) updateBatchNodeWithInfo:(KJGraphicalObject *) go;
- (void) updateSpritePart:(KJGraphicsPart *) part;
@end

@implementation KJCocosComplexSpriteObject (hidden)
- (void) updateBatchNodeWithInfo:(KJGraphicalObject *) go {
    
    if (![go shouldIgnoreBatchNodeUpdate]) {
        
        //CGSize spriteBatchFrameSize = [[[[batchNode children] objectAtIndex:0] displayedFrame] originalSizeInPixels];
        
        //double xOffset = ([p anchorPoint].x - 0.5f) * spriteBatchFrameSize.width/CC_CONTENT_SCALE_FACTOR();
        //double yOffset = ([p anchorPoint].y - 0.5f) * spriteBatchFrameSize.height/CC_CONTENT_SCALE_FACTOR();
        
        double xOffset = ([go anchorPoint].x - 0.5f) * [go boundingBox].size.width;
        double yOffset = ([go anchorPoint].y - 0.5f) * [go boundingBox].size.height;
        
        
        CGPoint frameOffset = [self frameOffset];
        //frameOffset = ccpMult(frameOffset, 1.0);
        frameOffset = ccpMult(frameOffset, 1.0/CC_CONTENT_SCALE_FACTOR());
        
        CGPoint offsetAP = CGPointMake(frameOffset.x - xOffset, frameOffset.y - yOffset);        
        
        [batchNode setPosition:ccpAdd([go position], offsetAP)]; 
        [batchNode setRotation:[go rotation]];
        
        [batchNode setScaleX:[go scaleX]];
        [batchNode setScaleY:[go scaleY]];
        
        [batchNode setVertexZ:[go vertexZ]];
        [batchNode setZOrder:[go zOrder]]; // maybe slow?
        
        [batchNode setVertexZ:[go vertexZ]];
        [batchNode setZOrder:[go zOrder]];
        
        [[self rootNode] setVertexZ:[go vertexZ]];
        [[self rootNode] setZOrder:[go zOrder]];
        
        [[rootNode parent] reorderChild:rootNode z:[go zOrder]]; // key!
        
        [batchNode setVisible:[go visible]];
        
        [batchNode setAnchorPoint:[go anchorPoint]];
    }
}
- (void) updateSpritePart:(KJGraphicsPart *) part {
    
    KJCocosGraphicObject *cgo = [sprites objectForKey:[part objectName]];
    
    if (cgo == nil) { return; }
    
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[part spriteFrameName]];
    
    CCSprite *s;
    if (![[cgo rootNode] isKindOfClass:[CCSprite class]]) { return; } else {
        s = (CCSprite *)[cgo rootNode];
    }
    
    if (frame != [s displayedFrame]) {
        [s setDisplayFrame:frame];
    }
    
    
    [s setPosition:[part position]];
    [s setRotation:[part rotation]];
    
    [s setScaleX:[part scaleX]];
    [s setScaleY:[part scaleY]];
    
    int zOrder = (int)([part vertexZ] * 100);
    float vz  = [[(KJGraphicsPart *)part parent]  vertexZ] + [part vertexZ];
    
    [s setVertexZ:vz];
    [s setZOrder:zOrder]; // maybe slow?
    
    //[s setVertexZ:[part vertexZ]];
    //[s setZOrder:[part zOrder]];
    
    [s setVisible:[part visible]];
    
    [s setFlipX:[part flipX]];
    [s setFlipY:[part flipY]];
    
    [s setAnchorPoint:[part anchorPoint]];
    
}
@end



@implementation KJCocosComplexSpriteObject

- (id) initWithGraphicalObject:(KJGraphicalObject *) sObj 
{
    if (( self = [super initWithNode:[CCNode node]] )) {        
        [self setupWithGraphicalObject:sObj];
        return self;
    } else {
        return nil;
    }
}
+ (id) objectWithGraphicalObject:(KJGraphicalObject *) sObj
{
    return [[[KJCocosComplexSpriteObject alloc] initWithGraphicalObject:sObj] autorelease];
}
- (void) setupWithGraphicalObject:(KJGraphicalObject *) sObj
{
    [self setObjectName:[sObj objectName]];
    
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithCapacity:[[[sObj parts] allValues] count]];    
    for (KJGraphicsPart *part in [[sObj parts] allValues]) {
        
        KJCocosGraphicObject *cgo = [KJCocosGraphicObject nodeWithNode:[CCSprite node]];
        [cgo setObjectName:[part objectName]];
        [temp setObject:cgo forKey:[part objectName]];
        [cgo setShouldIgnoreBoundingBoxCalculation:[part shouldIgnoreBoundingBox]];
    }
    sprites = [temp retain];
    
    for (KJGraphicsPart *part in [[sObj parts] allValues]) {                
        
        [self updateSpritePart:part];
        
        KJCocosGraphicObject *cgo = [sprites objectForKey:[part objectName]];
        CCSprite *s = (CCSprite *)[cgo rootNode];
        
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
        
        [part setSpriteRep:cgo];
        
    }
    
    // if batchNode is nil, then we have a graphicless object... this is ok.
    if (batchNode != nil) {
        [rootNode addChild:batchNode z:[sObj zOrder]];
    }
    
    [self updateComplexBoundingBox];
}
- (void) dealloc
{
    [super dealloc];
}

- (void) update:(double)dt
{
}

- (void) updateWithGraphical:(KJGraphicalObject *)updateObject {
    
    [self updateBatchNodeWithInfo:updateObject];
    
    for (KJGraphicsPart *part in [[updateObject parts] allValues]) {
        
        [self updateSpritePart:part];
        
    }
    
}

- (void) updateComplexBoundingBox {
    
    
    graphicBoundingBox.size = CGSizeMake(0.0, 0.0);
    graphicBoundingBox.origin = ccp(0.0,0.0);
    
    
    
    for (KJCocosGraphicObject *cgo in [sprites allValues]) {
        
        if (![cgo shouldIgnoreBoundingBoxCalculation]) {
            
            CCSpriteFrame *frame = [(CCSprite *)[cgo rootNode] displayedFrame];
            CGRect fixedRect = CGRectMake(frame.rect.origin.x, frame.rect.origin.y, 
                                          frame.rect.size.width, frame.rect.size.height);
            
            if ([frame rotated]) {
                float height = fixedRect.size.height;
                fixedRect.size.height = fixedRect.size.width;
                fixedRect.size.width = height;
            }
            
            fixedRect.origin =  ccp([frame offsetInPixels].x/CC_CONTENT_SCALE_FACTOR(), [frame offsetInPixels].y/CC_CONTENT_SCALE_FACTOR());
            fixedRect.origin = ccpSub(fixedRect.origin, ccp(fixedRect.size.width*0.5, fixedRect.size.height*0.5));
            
            if (graphicBoundingBox.size.width == 0) {
                graphicBoundingBox = fixedRect;
            } else {
                graphicBoundingBox = CGRectUnion(graphicBoundingBox, fixedRect);                
            }    
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

- (void) attachToLayer:(CCLayer *) layer
{
    [layer addChild:rootNode z:[batchNode zOrder]];
}
- (void) setBatchNode:(CCSpriteBatchNode *) sbn
{
    if (batchNode != nil) { [batchNode removeFromParentAndCleanup:YES]; batchNode = nil; }
    
    batchNode = [sbn retain];
    
    for (KJCocosGraphicObject *cgo in [sprites allValues]) {
        
        CCSprite *s = (CCSprite *)[cgo rootNode];
        
        [s removeFromParentAndCleanup:YES];
        
        [batchNode addChild:s z:[s zOrder]];
        [s setUsesBatchNode:YES];
        [s setBatchNode:batchNode];
        
    }
}
- (CCSpriteBatchNode *) batchNode
{
    return batchNode;
}

@end
