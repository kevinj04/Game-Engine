//
//  KJModule.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJModule.h"
#import "KJGraphicalObject.h"

NSString *const modClass = @"class";
NSString *const modId = @"id";
NSString *const modHashSuffix = @"#";
NSString *const modAtSuffix = @"@";

NSString *const modAnimationRequest = @"animationRequest";

static int kjModuleIdTag;

@implementation KJModule

@synthesize parent = _parent;
@synthesize moduleName = _moduleName;
@synthesize moduleId = _moduleId;

#pragma mark - Initialization Methods
+(void) initialize {
    kjModuleIdTag = 0;
    [super initialize];
}
+(int) kjModuleIdTag {
    return kjModuleIdTag++;
}
- (id) init
{
    self = [super init];
    if (self) { [self setup]; }
    return self;
}
- (id) initWithDictionary:(NSDictionary *) dictionary
{
    self = [super init];
    if (self)
    {
        [self setup];
        [self setupWithDictionary:dictionary];
    }
    return self;
}
+ (id) module
{
    return [[[KJModule alloc] init] autorelease];
}
+ (id) moduleWithDictionary:(NSDictionary *) dictionary
{
    return [[[KJModule alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setup
{
    // TODO: Rethink this logic
    // Allows the parent to listen to animation requests from all KJModules.
    [[NSNotificationCenter defaultCenter] addObserver:(KJGraphicalObject *)self.parent 
                                             selector:@selector(handleAnimationRequest:) 
                                                 name:modAnimationRequest 
                                               object:self];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary
{
    self.moduleName = [[NSString stringWithFormat:@"defaultModule"] retain];
    self.moduleId = [[NSString stringWithFormat:@"defaultId"] retain];

    if ([dictionary objectForKey:modClass] != nil) {
        self.moduleName = [[dictionary objectForKey:modClass] retain];
    }    
    
    if ([dictionary objectForKey:modId] != nil) {
        self.moduleId = [[dictionary objectForKey:modId] retain];
        
        if ([self.moduleId hasSuffix:modHashSuffix]) {
            self.moduleId = [[self.moduleId stringByReplacingOccurrencesOfString:modHashSuffix withString:[NSString stringWithFormat:@"%i", kjModuleIdTag++]] retain];
        }
    }
}
- (void) setupWithGameObject:(KJCommonGameObject *) obj
{
    self.parent = [obj retain];

    if ([self.moduleId hasSuffix:modAtSuffix]) {
        self.moduleId = [[self.moduleId stringByReplacingOccurrencesOfString:modAtSuffix withString:[NSString stringWithFormat:@"%@", [self.parent objectId]]] retain];
    }
}
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.parent != nil) { [self.parent release]; self.parent = nil; }    
    [super dealloc];
}

#pragma mark - Update
- (void) update:(double) dt
{
    // Game logic goes here, subclass KJModule and attach modules to KJCommonGameObjects. Modules can reference their parents to adjust properties.
}

#pragma mark - Setters and Getters
- (void) setParent:(KJCommonGameObject *) p
{
    if (self.parent != nil) { [self.parent release]; self.parent = nil; }
    if (p == nil) return;
    self.parent = [p retain];
}
- (KJCommonGameObject *) parent
{
    return self.parent;
}
- (void) setLayer:(KJLayer *)l
{
    // override to handle this...
}

#pragma mark - Clean Up
- (void) detach {
    // override this to remove all components from any connections so that this deallocates nicely.
}

@end
