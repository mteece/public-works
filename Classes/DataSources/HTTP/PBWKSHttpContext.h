//
//  PBWKSHttpContext.h
//  Public Works
//
//  Created by Matthew Teece on 4/22/14.
//  Copyright (c) 2014 Matthew Teece. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBWKSHttpContext : NSObject

@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *format;
@property (nonatomic, assign) float version;
@property (nonatomic, copy) NSDictionary *options;

@end
