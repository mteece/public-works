//
//  PBWKSHttpClientTest.m
//  Public Works
//
//  Created by Matthew Teece on 4/13/14.
//  Copyright (c) 2014 Matthew Teece. All rights reserved.
//

#import "PBWKSHttpClient.h"

#import <XCTest/XCTest.h>

@interface PBWKSHttpClientTest : XCTestCase

@end

@implementation PBWKSHttpClientTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testClientCanAllocateSingleton
{
    //NSURL *url = [[NSURL alloc] initWithString:@"http://www.unittest.com"];
    NSDictionary *webContext = @{@"url" : @"http://www.unittest.com",
                                 @"format" : @"json",
                                 @"version" : @"1"};
    
    PBWKSHttpClient *client = [PBWKSHttpClient sharedPBWKSHttpClient];
    [client registerContext:webContext];
    
    XCTAssertNotNil(client, @"PBWKSHttpClient cannot be nil.");
    //XCTAssertTrue([client baseURL], @"http://www.unittest.com");
}

@end
