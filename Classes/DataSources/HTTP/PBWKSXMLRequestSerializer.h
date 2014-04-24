//
//  PBWKSXMLRequestSerializer.h
//  Public Works
//
//  Created by Matthew Teece on 4/24/14.
//  Copyright (c) 2014 Matthew Teece. All rights reserved.
//
// http://cocoadocs.org/docsets/AFNetworking/2.2.3/Protocols/AFURLRequestSerialization.html

#import "AFURLRequestSerialization.h"

@interface PBWKSXMLRequestSerializer : AFHTTPRequestSerializer

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request withParameters:(id)parameters error:(NSError *__autoreleasing *)error;

@end
