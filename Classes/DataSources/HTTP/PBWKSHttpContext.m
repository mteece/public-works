//
//  PBWKSHttpContext.m
//  Public Works
//
//  Created by Matthew Teece on 4/22/14.
//  Copyright (c) 2014 Matthew Teece. All rights reserved.
//

#import "PBWKSHttpContext.h"

@implementation PBWKSHttpContext

@synthesize baseUrl;
@synthesize format;
@synthesize version;
@synthesize options;

- (instancetype)init {
    self = [super init];
    if (self) {
        // TODO: Default properties.
    }
    return self;
}

@end
