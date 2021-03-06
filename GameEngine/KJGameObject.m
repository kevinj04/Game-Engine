//
//  KJGameObject.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJGameObject.h"
#import "KJObjectManager.h"

NSString *const kjParentId = @"parentId";
NSString *const kjObjectType = @"type";
NSString *const kjObjectId = @"id";
NSString *const kjObjectName = @"name";
NSString *const kjParameters = @"parameters";
NSString *const kjSelected = @"gameElementSelected";
NSString *const kjAlwaysActive = @"alwaysActive";

NSString *const kjObjectActivated = @"objectActivated";
NSString *const kjObjectDeactivated = @"objectDeactivated";
NSString *const kjObjectSetAlwaysActive = @"setAlwaysActive";
NSString *const kjObjectSetNotAlwaysActive = @"setNotAlwaysActive";

@implementation KJGameObject

@synthesize parent = _parent;
@synthesize parentId = _parentId;
@synthesize objectId = _objectId;
@synthesize objectName = _objectName;
@synthesize objectType = _objectType;
@synthesize isActive = _isActive;
@synthesize isAlwaysActive = _isAlwaysActived;
@synthesize inActiveWindow = _inActiveWindow;

#pragma mark -
#pragma mark Initialization
- (id) init {

    if (( self = [super init] )) {

        [self registerNotifications];
        [self setup];

        return self;
    } else {
        return nil;
    }

}
- (id) initWithDictionary:(NSDictionary *)dictionary {

    if (( self = [super init] )) {

        [self registerNotifications];
        [self setupWithDictionary:dictionary];

        return self;
    } else {
        return nil;
    }

}
+ (id) object {
    return [[[KJGameObject alloc] init] autorelease];
}
+ (id) objectWithDictionary:(NSDictionary *) dictionary {
    return [[[KJGameObject alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setup {

    _parentId = nil;
    self.parent = nil;

    self.objectType = 0;
    self.objectId = @"defaultObjectId";
    self.objectName = @"defaultObjectName";

    self.isActive = NO;
    self.isAlwaysActive = NO;
    self.inActiveWindow = NO;
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {

    [self setup];

    if ([dictionary objectForKey:kjParentId] != nil) {
        self.parentId = [dictionary objectForKey:kjParentId];
    }

    if ([dictionary objectForKey:kjObjectType] != nil) {
        self.objectType = [[dictionary objectForKey:kjObjectType] intValue];
    }

    if ([dictionary objectForKey:kjObjectId] != nil) {
        self.objectId = [dictionary objectForKey:kjObjectId];
    }

    if ([dictionary objectForKey:kjObjectName] != nil) {
        self.objectName = [dictionary objectForKey:kjObjectName];
    }

    if ([dictionary objectForKey:kjAlwaysActive] != nil) {
        self.isAlwaysActive = [[dictionary objectForKey:kjAlwaysActive] boolValue];
    }

}
- (void) registerNotifications {
    // handled by subclasses
}
- (void) dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];

    if (self.objectId != nil) { [_objectId release]; _objectId = nil; }
    if (self.objectName != nil) { [_objectName release]; _objectName = nil; }
    if (self.parentId != nil) { [_parentId release]; _parentId = nil; }
    if (self.parent != nil) { [_parent release]; _parent = nil; }

    [super dealloc];
}
#pragma mark -

#pragma mark Tick Method
- (void) update:(double) dt {

}
#pragma mark -

#pragma mark Getters and Setters
- (void) setIsAlwaysActive:(bool) b
{
    if (b == _isAlwaysActived) return;

    if (b)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kjObjectSetAlwaysActive object:self];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kjObjectSetNotAlwaysActive object:self];
    }

    _isAlwaysActived = b;
}
- (void) setIsActive:(bool) b
{
    if (self.isAlwaysActive) {
        NSLog(@"Attempting to set object's active level, but object is always active.");
        return;
    }
    if (b && !self.isActive) { [[NSNotificationCenter defaultCenter] postNotificationName:kjObjectActivated object:self]; }
    if (!b && self.isActive) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kjObjectDeactivated object:self];
    }
    _isActive = b;
}
- (void) setParent:(KJLayer *)parent
{
    _parentId = [[parent objectId] retain];
    _parent = [parent retain];
}
#pragma mark -


@end
