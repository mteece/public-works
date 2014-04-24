//
//  PBWKSXMLRequestSerializer.m
//  Public Works
//
//  Created by Matthew Teece on 4/24/14.
//  Copyright (c) 2014 Matthew Teece. All rights reserved.
//

#import "PBWKSXMLRequestSerializer.h"

@implementation PBWKSXMLRequestSerializer

- (NSURLRequest*)requestBySerializingRequest:(NSURLRequest *)request withParameters:(NSDictionary *)parameters error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(request);
    
    if ([self.HTTPMethodsEncodingParametersInURI containsObject:[[request HTTPMethod] uppercaseString]]) {
        return [super requestBySerializingRequest:request withParameters:parameters error:error];
    }
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    [self.HTTPRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        if (![request valueForHTTPHeaderField:field]) {
            [mutableRequest setValue:value forHTTPHeaderField:field];
        }
    }];
    
    NSData *theBodyData = [NSPropertyListSerialization dataFromPropertyList:parameters format:NSPropertyListXMLFormat_v1_0 errorDescription:nil];
    
    // TODO: https://github.com/uacaps/NSObject-ObjectMap to post body as NSData.
    
    [mutableRequest setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [mutableRequest setHTTPBody:theBodyData];
    
    return mutableRequest;
}

@end
