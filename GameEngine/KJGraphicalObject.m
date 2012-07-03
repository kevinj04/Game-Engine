//
//  KJGraphicalObject.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJGraphicalObject.h"
#import "KJGraphicsPart.h"
#import "KJLayer.h"

NSString *const kjObjectParts = @"parts";
NSString *const kjObjectAnimations = @"animations";
NSString *const kjObjectRunningAnimation = @"runningAnimation";
NSString *const kjVertexZ = @"vertexZ";
NSString *const kjZOrder = @"zOrder";
NSString *const kjPrimaryPart = @"primaryPart";
NSString *const kjShouldIgnoreBatchNodeUpdate = @"ignoreBatchNodeUpdate";
NSString *const kjAnimationRequest = @"animationRequest";
NSString *const kjTargetPart = @"targetPart";

@implementation KJGraphicalObject

@synthesize scaleX = _scaleX;
@synthesize scaleY = _scaleY;
@synthesize animationSpeed = _animationSpeed;
@synthesize vertexZ = _vertexZ;
@synthesize zOrder = _zOrder;
@synthesize visible = _visible;
@synthesize flipX = _flipX;
@synthesize flipY = _flipY;
@synthesize shouldIgnoreBatchNodeUpdate = _shouldIgnoreBatchNodeUpdate;
@synthesize primaryPart = _primaryPart;
@synthesize parts = _parts;

#pragma mark - Initialization
- (id) init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}
+ (id) object
{
    return [[[KJGraphicalObject alloc] init] autorelease];
}
- (void) setup
{
    self.scaleX = 1.0;
    self.scaleY = 1.0;
    self.animationSpeed = 1.0;
    self.vertexZ = 0.0;
    self.zOrder = 0;
    self.visible = YES;
    self.flipX = NO;
    self.flipY = NO;
    self.primaryPart = [NSString stringWithFormat:@""];

    // empty, only mutable through setupGraphicsWithDictionary method.
    self.parts = nil;

    [super setup];
}
- (id) initWithDictionary:(NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    return self;
}
+ (id) objectWithDictionary:(NSDictionary *) dictionary
{
    return [[[KJGraphicalObject alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *)dictionary
{
    [self setup];

    [super setupWithDictionary:dictionary];

    NSDictionary *params;
    if ((params = [dictionary objectForKey:kjParameters])) {

        if ([params objectForKey:kjVertexZ] != nil) {
            self.vertexZ = [[params objectForKey:kjVertexZ] floatValue];
        }

        if ([params objectForKey:kjZOrder] != nil) {
            self.zOrder = [[params objectForKey:kjZOrder] intValue];
        }
    }
}
- (void) registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAnimationNotification:) name:kjAnimationRequest object:self];
}
- (void) dealloc
{
    if (self.parts != nil) { [_parts release]; self.parts = nil; }
    if (self.primaryPart != nil) { [_primaryPart release]; self.primaryPart = nil; }

    [super dealloc];
}

#pragma mark - Event Handlers
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

#pragma mark - Update Method
- (void) update:(double) dt
{
    [super update:dt];

    if (self.isActive || self.isAlwaysActive)
    {
        for (KJGraphicsPart *part in [self.parts allValues])
        {
            [part update:dt*self.animationSpeed];
        }
    }
}

#pragma mark - Animation Methods
- (void) setupGraphicsWithDictionary:(NSDictionary *) animationDictionary
{
    if ([animationDictionary objectForKey:kjPrimaryPart] != nil) {
        self.primaryPart = [animationDictionary objectForKey:kjPrimaryPart];
    }

    self.shouldIgnoreBatchNodeUpdate = NO;
    if ([animationDictionary objectForKey:kjShouldIgnoreBatchNodeUpdate] != nil) {
        self.shouldIgnoreBatchNodeUpdate = [[animationDictionary objectForKey:kjShouldIgnoreBatchNodeUpdate] boolValue];
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

        self.parts = [NSDictionary dictionaryWithDictionary:tempParts];

    } else {
        self.parts = [NSDictionary dictionary];
    }
}

- (void) runAnimation:(NSString *) animationName onPart:(NSString *) partName
{
    if ([self.parts objectForKey:partName] != nil)
    {
        [[self.parts objectForKey:partName] runAnimation:animationName];
    }
}
- (void) runAnimation:(NSString *) animationName
{
    for (KJGraphicsPart *part in [self.parts allValues])
    {
        [part runAnimation:animationName];
    }
}

#pragma mark - Part Modifiers
/** These are access methods to individual parts which can set a 'master' value. This value is applied relatively to the value stored in this instance. Ex: If the main sprite has flipX = YES, then all the parts will flip along the x-axis. If one part has a master value of flipX = YES (default would be no), then it will be flipped twice, unflipping the sprite. **/
- (void) setPosition:(CGPoint) p forPart:(NSString *) partName
{
    if ([self.parts objectForKey:partName] == nil) return;
    [[self.parts objectForKey:partName] setMasterPosition:p];
}
- (void) setFlipX:(bool) b forPart:(NSString *) partName
{
    if ([self.parts objectForKey:partName] == nil) return;
    [[self.parts objectForKey:partName] setMasterFlipX:b];
}
- (void) setFlipY:(bool) b forPart:(NSString *) partName
{
    if ([self.parts objectForKey:partName] == nil) return;
    [[self.parts objectForKey:partName] setMasterFlipY:b];
}
- (void) setRotation:(float)r forPart:(NSString *) partName
{
    if ([self.parts objectForKey:partName] == nil) return;
    [[self.parts objectForKey:partName] setMasterRotation:r];
}
- (void) setScaleX:(float) f forPart:(NSString *) partName
{
    if ([self.parts objectForKey:partName] == nil) return;
    [[self.parts objectForKey:partName] setMasterScaleX:f];
}
- (void) setScaleY:(float) f forPart:(NSString *) partName
{
    if ([self.parts objectForKey:partName] == nil) return;
    [[self.parts objectForKey:partName] setMasterScaleY:f];
}
- (void) setIsActive:(bool)b
{
    [super setIsActive:b];
}
- (void) detachParts
{
    for (KJGraphicsPart *p in [self.parts allValues])
    {
        [p setParent:nil];
    }
}
- (void) setZOrder:(int)z
{
    _zOrder = z;
    self.vertexZ = self.zOrder;
    if (self.parent) { self.vertexZ += self.parent.vertexZ; }
}

- (void) setParent:(KJLayer *)parent
{
    [super setParent:parent];
    if (self.parent) { self.vertexZ += self.parent.vertexZ; }
}

#pragma mark - Position Modifiers
- (CGPoint) primaryPartOffset
{
    if ([self.primaryPart isEqualToString:[NSString stringWithFormat:@""]]) return CGPointMake(0.0, 0.0);
    return [[self.parts objectForKey:self.primaryPart] frameOffset];
}

@end
