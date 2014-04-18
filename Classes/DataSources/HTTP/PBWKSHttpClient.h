//
//  PBWKSHttpClient.h
//  Public Works
//
//  Created by Matthew Teece on 4/13/14.
//  Copyright (c) 2014 Matthew Teece. All rights reserved.
//

@class AFHTTPSessionManager;

@interface PBWKSHttpClient : NSObject

+ (PBWKSHttpClient *)sharedPBWKSHttpClient;
- (void)registerContext:(NSDictionary *)context;
- (void)unregisterContext;

@end
