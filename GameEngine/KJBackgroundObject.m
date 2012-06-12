//
//  KJBackgroundObject.m
//  GameEngine
//
//  Created by Kevin Jenkins on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KJBackgroundObject.h"
#import "Universalizer.h"

NSString *const kjImage = @"image";

@implementation KJBackgroundObject

@synthesize backgroundFileName = _backgroundFileName;

#pragma mark - Initialization Methods
- (id) initWithDictionary:(NSDictionary *) dictionary
{
    self = [super init];

    if (self)
    {
        [self setupWithDictionary:dictionary];
    }

    return self;
}
+ (id) tileWithDictionary:(NSDictionary *) dictionary
{
    return [[[KJBackgroundObject alloc] initWithDictionary:dictionary] autorelease];
}
- (void) setupWithDictionary:(NSDictionary *) dictionary
{
    [super setupWithDictionary:dictionary];

    NSDictionary *params = [dictionary objectForKey:kjParameters];

    if ([params objectForKey:kjImage] != nil) {
        self.backgroundFileName = [params objectForKey:kjImage];
    } else {
        NSAssert(NO, @"Failed to load an image for this background object.");
    }

    self.position = CGPointZero;
    if ([params objectForKey:kjParameters] != nil) {
        self.position = [Universalizer scalePointForIPad:CGPointFromString([params objectForKey:kjObjectPosition])];
    }
}
- (void) dealloc {
    if (self.backgroundFileName != nil) { [_backgroundFileName release]; _backgroundFileName = nil; }
    [super dealloc];
}

@end
