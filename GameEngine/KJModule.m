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
@synthesize moduleName, moduleId;
#pragma mark -

#pragma mark Initialization Methods
+(void) initialize {
    kjModuleIdTag = 0;
    [super initialize];
}
+(int) kjModuleIdTag {
    return kjModuleIdTag++;
}
- (id) init 
{
    
    if ((self = [super init] )) 
    {
        
        [self setup];
        return self;
        
    }
    return nil;
}
- (id) initWithDictionary:(NSDictionary *) dictionary {
    
    if (( self = [super init] )) {
        
        [self setup];
        [self setupWithDictionary:dictionary];
        return self;
        
    }
    return nil;
}
+ (id) module {
    return [[[KJModule alloc] init] autorelease];
}
+ (id) moduleWithDictionary:(NSDictionary *) dictionary {
    return [[[KJModule alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setup {
    // Subclass me.
    
    // Allows the parent to listen to animation requests from all KJModules.
    [[NSNotificationCenter defaultCenter] addObserver:(KJGraphicalObject *)parent 
                                             selector:@selector(handleAnimationRequest:) 
                                                 name:modAnimationRequest 
                                               object:self];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary {
    // Subclass me.
    
    moduleName = [[NSString stringWithFormat:@"defaultModule"] retain];
    moduleId = [[NSString stringWithFormat:@"defaultId"] retain];

    if ([dictionary objectForKey:modClass] != nil) {
        moduleName = [[dictionary objectForKey:modClass] retain];
    }    
    
    if ([dictionary objectForKey:modId] != nil) {
        moduleId = [[dictionary objectForKey:modId] retain];
        
        if ([moduleId hasSuffix:modHashSuffix]) {
            moduleId = [[moduleId stringByReplacingOccurrencesOfString:modHashSuffix withString:[NSString stringWithFormat:@"%i", kjModuleIdTag++]] retain];
        }
    }
}
- (void) setupWithGameObject:(KJCommonGameObject *) obj {
    
    parent = [obj retain];
    
    if ([moduleId hasSuffix:modAtSuffix]) {
        moduleId = [[moduleId stringByReplacingOccurrencesOfString:modAtSuffix withString:[NSString stringWithFormat:@"%@", [parent objectId]]] retain];
    }
    
    // subclass me.
}
- (void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (parent != nil) { [parent release]; parent = nil; }
    
    [super dealloc];
}
#pragma mark -

#pragma mark Tick Update
- (void) update:(double) dt {
    
    // Game logic goes here, subclass KJModule and attach modules to KJCommonGameObjects. Modules can reference their parents to adjust properties.
    
}
#pragma mark -

#pragma mark Setters and Getters
- (void) setParent:(KJCommonGameObject *) p {
    if (parent != nil) { [parent release]; parent = nil; }
    if (p == nil) return;
    parent = [p retain];
}
- (KJCommonGameObject *) parent {
    return parent;
}
- (void) setLayer:(KJLayer *)l 
{
    // override to handle this...
}
#pragma mark -

- (void) detach {
    // override this to remove all components from any connections so that this deallocates nicely.
}

@end
