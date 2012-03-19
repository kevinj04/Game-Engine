//
//  GraphicalGameElement.m
//  TestGame
//
//  Created by Kevin Jenkins on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphicalGameElement.h"
#import <UIKit/UIKit.h>
#import <OpenGLES/ES1/gl.h>
#import "Universalizer.h"

typedef struct _ccVertex2F
{
	GLfloat x;
	GLfloat y;
} ccVertex2F;

@interface GraphicalGameElement (hidden) 
- (void) updateColor;
- (void) updateGraphicsWithInfo:(NSObject<SpriteUpdateProtocol> *) p;
- (void) drawPoint:(CGPoint) p;
@end

@implementation GraphicalGameElement (hidden)
- (void) drawPoint:(CGPoint) p {
    p = [Universalizer scalePointForIPad:p];
	ccVertex2F p2 = (ccVertex2F) {p.x, p.y};
	
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states: GL_VERTEX_ARRAY, 
	// Unneeded states: GL_TEXTURE_2D, GL_TEXTURE_COORD_ARRAY, GL_COLOR_ARRAY	
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);
	
	glVertexPointer(2, GL_FLOAT, 0, &p2);	
	glDrawArrays(GL_POINTS, 0, 1);
    
	// restore default state
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);	
}
- (void) updateGraphicsWithInfo:(NSObject<SpriteUpdateProtocol> *) p {
    [self setPosition:[p position]];
    [self setRotation:[p rotation]];
    
    [self setScaleX:[p scaleX]];
    [self setScaleY:[p scaleY]];
    
    [self setVertexZ:[p vertexZ]];
    [self setZOrder:[p zOrder]]; // maybe slow?
    [self setVisible:[p visible]];
    
    [self setAnchorPoint:[p anchorPoint]];
}
- (void) updateColor {
    if ([spriteFrameName isEqualToString:@"BLUE"]) {
        glColor4ub(0,0,255,255);
    } else if ([spriteFrameName isEqualToString:@"PURPLE"]) {
        glColor4ub(123,0,255,255);
    } else if ([spriteFrameName isEqualToString:@"RED"]) {
        glColor4ub(255,0,0,255);
    } else if ([spriteFrameName isEqualToString:@"GREEN"]) {
        glColor4ub(0,255,0,255);
    } else if ([spriteFrameName isEqualToString:@"CYAN"]) {
        glColor4ub(0,255,255,255);
    } else if ([spriteFrameName isEqualToString:@"YELLOW"]) {
        glColor4ub(255,255,0,255);
    } else {
        glColor4ub(255,255,255,255);
    }
}
@end


@implementation GraphicalGameElement

@synthesize name, position, rotation, scaleX, scaleY, vertexZ, zOrder, anchorPoint, boundingBox, spriteFrameName, visible;    

- (id) initWithSpriteObject:(SpriteObject *) sObj {
    
    if (( self = [super init] )) {
        
        [self setupWithSpriteObject:sObj];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) elementWithSpriteObject:(SpriteObject *) sObj {
    return [[[GraphicalGameElement alloc] initWithSpriteObject:sObj] autorelease];
}
- (void) setupWithSpriteObject:(SpriteObject *) sObj {
    
    name = [[sObj name] retain];
    
    [self updateGraphicsWithInfo:sObj];         
    
    
}
- (void) dealloc {
    [super dealloc];
}


- (void) draw {
    
    [self updateColor];
    glPointSize(roundf(scaleX));
    [self drawPoint:(position)];
    //NSLog(@"[DOT size=%2.0f] at %@", scale, NSStringFromCGPoint(position));
}

- (void) updateWithPhysicsInfo:(NSObject<SpriteUpdateProtocol> *)updateObj {
    
}

- (CGPoint) frameOffset {
    return CGPointMake(0.0, 0.0);
}

@end
