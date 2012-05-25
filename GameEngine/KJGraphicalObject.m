//
//  KJGraphicalObject.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJGraphicalObject.h"
#import "KJGraphicsPart.h"

NSString *const kjObjectParts = @"parts";
NSString *const kjObjectAnimations = @"animations";
NSString *const kjObjectRunningAnimation = @"runningAnimation";
NSString *const kjVertexZ = @"vertexZ";
NSString *const kjZOrder = @"zOrder";
NSString *const kjBody = @"spriteBody";
NSString *const kjShouldIgnoreBatchNodeUpdate = @"ignoreBatchNodeUpdate";

NSString *const kjAnimationRequest = @"animationRequest";
NSString *const kjTargetPart = @"targetPart";

@implementation KJGraphicalObject

@synthesize scaleX, scaleY, animationSpeed, vertexZ, zOrder, visible, flipX, flipY, shouldIgnoreBatchNodeUpdate,
primaryPart, parts;

- (id) init 
{
    
    if (( self = [super init] )) 
    {
        return self;
    } 
    
    return nil;
    
}
+ (id) object 
{
    return [[[KJGraphicalObject alloc] init] autorelease];
}
- (void) setup 
{
    
    scaleX = 1.0;
    scaleY = 1.0;
    
    animationSpeed = 1.0;   
    vertexZ = 0.0;
    zOrder = 0;
    
    visible = YES;
    
    flipX = NO;
    flipY = NO;
    
    primaryPart = [[NSString stringWithFormat:@""] retain];
    parts = [[NSDictionary dictionary] retain]; // empty, only mutable through setupGraphicsWithDictionary method.
    
    [super setup];
    
}
- (id) initWithDictionary:(NSDictionary *) dictionary 
{
    if (( self = [super initWithDictionary:dictionary])) 
    {
        return self;
    }
    return nil;
}
+ (id) objectWithDictionary:(NSDictionary *) dictionary 
{
    return [[[KJGraphicalObject alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *)dictionary 
{
    
    [super setupWithDictionary:dictionary];
    
    NSDictionary *params;
    if ((params = [dictionary objectForKey:kjParameters])) {
        
        if ([params objectForKey:kjVertexZ] != nil) {
            vertexZ = [[dictionary objectForKey:kjVertexZ] floatValue];
        }
        
        if ([params objectForKey:kjZOrder] != nil) {
            zOrder = [[dictionary objectForKey:kjZOrder] intValue];
        }
    }
    
}

- (void) handleAnimationNotification:(NSNotification *) notification {
    
    NSString *animationRequest;
    NSString *targetPart;
    
    if (( animationRequest = [[notification userInfo] objectForKey:kjAnimationRequest])) 
    {
        if (( targetPart = [[notification userInfo] objectForKey:kjTargetPart])) 
        {
            [self runAnimation:animationRequest onPart:targetPart];
        }
        
        [self runAnimation:animationRequest];
    }
    
}

- (void) registerNotifications 
{
    [super registerNotifications];
}
- (void) dealloc 
{
    
    if (parts != nil) { [parts release]; parts = nil; }
    if (primaryPart != nil) { [primaryPart release]; primaryPart = nil; }
    
    [super dealloc];
}
#pragma mark -


#pragma mark Tick Method
- (void) update:(double) dt 
{
    
    [super update:dt];
    
    for (KJGraphicsPart *part in [parts allValues]) 
    {
        [part update:dt*animationSpeed];
    }
    
}
#pragma mark -


#pragma mark Animation Methods

- (void) setupGraphicsWithDictionary:(NSDictionary *) animationDictionary 
{
    if ([animationDictionary objectForKey:kjBody] != nil) {
        primaryPart = [[animationDictionary objectForKey:kjBody] retain];
    }
    
    shouldIgnoreBatchNodeUpdate = NO;
    if ([animationDictionary objectForKey:kjShouldIgnoreBatchNodeUpdate] != nil) {
        shouldIgnoreBatchNodeUpdate = [[animationDictionary objectForKey:kjShouldIgnoreBatchNodeUpdate] boolValue];
    }
    
    if ([animationDictionary objectForKey:kjZOrder] != nil) {
        zOrder = [[animationDictionary objectForKey:kjZOrder] intValue];
    }
    
    if ([animationDictionary objectForKey:kjVertexZ] != nil) {
        vertexZ = [[animationDictionary objectForKey:kjVertexZ] floatValue];
    }
    
    NSDictionary *partsDictionary;
    if ((partsDictionary = [animationDictionary objectForKey:kjObjectParts])) {
        
        NSMutableDictionary *tempParts = [NSMutableDictionary dictionaryWithCapacity:[partsDictionary count]];
        
        for (NSString *partName in [partsDictionary allKeys]) {
            
            KJGraphicsPart *part = [KJGraphicsPart partWithAnimationDictionary:[partsDictionary objectForKey:partName]];
            [part setParent:self];
            [part setObjectName:partName];
            [tempParts setObject:part forKey:partName];
        }
        
        parts = [[NSDictionary alloc] initWithDictionary:tempParts];
        
    } else {
        parts = [[NSDictionary alloc] init];
    }
}

- (void) runAnimation:(NSString *) animationName onPart:(NSString *) partName 
{
    
    if ([parts objectForKey:partName] != nil) 
    {
        [[parts objectForKey:partName] runAnimation:animationName];        
    }
}
- (void) runAnimation:(NSString *) animationName 
{
    
    for (KJGraphicsPart *part in [parts allValues]) 
    {
        [part runAnimation:animationName];
    }
}
#pragma mark -

#pragma mark Part Modifiers
/** These are access methods to individual parts which can set a 'master' value. This value is applied relatively to the value stored in this instance. Ex: If the main sprite has flipX = YES, then all the parts will flip along the x-axis. If one part has a master value of flipX = YES (default would be no), then it will be flipped twice, unflipping the sprite. **/

- (void) setPosition:(CGPoint) p forPart:(NSString *) partName {
    
    if ([parts objectForKey:partName] == nil) return;
    
    [[parts objectForKey:partName] setMasterPosition:p];
}
- (void) setFlipX:(bool) b forPart:(NSString *) partName {
    
    if ([parts objectForKey:partName] == nil) return;
    
    [[parts objectForKey:partName] setMasterFlipX:b];
}
- (void) setFlipY:(bool) b forPart:(NSString *) partName {
    
    if ([parts objectForKey:partName] == nil) return;
    
    [[parts objectForKey:partName] setMasterFlipY:b];
}

- (void) setRotation:(float)r forPart:(NSString *) partName {    
    
    if ([parts objectForKey:partName] == nil) return;
    
    [[parts objectForKey:partName] setMasterRotation:r];
    
}
- (void) setScaleX:(float) f forPart:(NSString *) partName {
    if ([parts objectForKey:partName] == nil) return;
    
    [[parts objectForKey:partName] setMasterScaleX:f];
}
- (void) setScaleY:(float) f forPart:(NSString *) partName {
    if ([parts objectForKey:partName] == nil) return;
    
    [[parts objectForKey:partName] setMasterScaleY:f];
}

- (void) setIsActive:(bool)b {
    [self setVisible:b];
    [super setIsActive:b];
}
#pragma mark -

- (void) detachParts {
    
    for (KJGraphicsPart *p in [parts allValues]) {
        
        [p setParent:nil];
        
    }
    
}

#pragma mark Position Modifiers
- (CGPoint) primaryPartOffset { 
    if ([primaryPart isEqualToString:[NSString stringWithFormat:@""]]) return CGPointMake(0.0, 0.0);
    
    return [[parts objectForKey:primaryPart] frameOffset];
}
#pragma mark -


@end
