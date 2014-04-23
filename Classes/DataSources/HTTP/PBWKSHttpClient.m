//
//  PBWKSHttpClient.m
//  Public Works
//
//  Created by Matthew Teece on 4/13/14.
//  Copyright (c) 2014 Matthew Teece. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "PBWKSHttpContext.h"

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


- (AFHTTPSessionManager *)setupClientForContext:(PBWKSHttpContext *)context {
    AFHTTPSessionManager *httpSessionClient = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[context baseUrl]]];
    
    if([[context format] isEqualToString:@"json"]) {
        httpSessionClient.responseSerializer = [AFJSONResponseSerializer serializer];
        httpSessionClient.requestSerializer = [AFJSONRequestSerializer serializer];
    } else {
        httpSessionClient.responseSerializer = [AFXMLParserResponseSerializer serializer];
        httpSessionClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
        // TODO: Need a request serializer.
    }
   
    
    //[httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    //[httpClient setDefaultHeader:@"Accept" value:@"application/json"];
    return httpSessionClient;
}


- (void)registerContext:(PBWKSHttpContext *)context {
    self.httpSessionManager = [self setupClientForContext:context];
}

- (void)unregisterContext {
    
    self.httpSessionManager = nil;
}

@end
