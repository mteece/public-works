//
//  PBWKSHttpClient.m
//  Public Works
//
//  Created by Matthew Teece on 4/13/14.
//  Copyright (c) 2014 Matthew Teece. All rights reserved.
//

#import "AFHTTPSessionManager.h"

#import "PBWKSHttpClient.h"

@interface PBWKSHttpClient()

- (AFHTTPSessionManager *)setupClientForContext:(NSDictionary *)context;
@property AFHTTPSessionManager *httpSessionManager;

@end

@implementation PBWKSHttpClient

+ (PBWKSHttpClient *)sharedPBWKSHttpClient {
    static PBWKSHttpClient *_sharedPBWKSHttpClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPBWKSHttpClient = [[self alloc] init];
    });
    return _sharedPBWKSHttpClient;
}


- (AFHTTPSessionManager *)setupClientForContext:(NSDictionary *)context {
    AFHTTPSessionManager *httpSessionClient = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[context objectForKey:@"url"]]];
    
    httpSessionClient.responseSerializer = [AFJSONResponseSerializer serializer];
    httpSessionClient.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //[httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    //[httpClient setDefaultHeader:@"Accept" value:@"application/json"];
    return httpSessionClient;
}


- (void)registerContext:(NSDictionary *)context {
    self.httpSessionManager = [self setupClientForContext:context];
}

- (void)unregisterContext {
    
    self.httpSessionManager = nil;
}

@end
