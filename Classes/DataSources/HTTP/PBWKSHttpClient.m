//
//  PBWKSHttpClient.m
//  Public Works
//
//  Created by Matthew Teece on 4/13/14.
//  Copyright (c) 2014 Matthew Teece. All rights reserved.
//

#import "PBWKSConstants.h"
#import "AFHTTPSessionManager.h"
#import "AFRaptureXMLRequestOperation.h"
#import "PBWKSHttpContext.h"
#import "PBWKSXMLRequestSerializer.h"

#import "PBWKSHttpClient.h"

@interface PBWKSHttpClient()

- (AFHTTPSessionManager *)setupClientForContext:(NSDictionary *)context;

@end

@implementation PBWKSHttpClient

@synthesize httpSessionManager;

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
    
    switch ([context requestFormat]) {
        case PBWKSHttpRequestFormatJSON:
            httpSessionClient.responseSerializer = [AFJSONResponseSerializer serializer];
            httpSessionClient.requestSerializer = [AFJSONRequestSerializer serializer];

            break;
        case PBWKSHttpRequestFormatXML:
            httpSessionClient.responseSerializer = [AFXMLParserResponseSerializer serializer];
            httpSessionClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
            
            httpSessionClient.requestSerializer = [PBWKSXMLRequestSerializer serializer];
            // TODO: Need a request serializer.

            break;
        default:
            httpSessionClient.responseSerializer = [AFHTTPResponseSerializer serializer];
             httpSessionClient.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
    }
    
    return httpSessionClient;
}


- (void)registerContext:(PBWKSHttpContext *)context {
    self.httpSessionManager = [self setupClientForContext:context];
}

- (void)unregisterContext {
    
    self.httpSessionManager = nil;
}

@end
