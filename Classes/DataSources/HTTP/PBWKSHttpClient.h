//
//  PBWKSHttpClient.h
//  Public Works
//
//  Created by Matthew Teece on 4/13/14.
//  Copyright (c) 2014 Matthew Teece. All rights reserved.
//

@class AFHTTPSessionManager;
@class PBWKSHttpContext;

@interface PBWKSHttpClient : NSObject

+ (PBWKSHttpClient *)sharedPBWKSHttpClient;
- (void)registerContext:(PBWKSHttpContext *)context;
- (void)unregisterContext;

@end
