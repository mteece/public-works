//
//  PBWKSHttpContextTest.m
//  Public Works
//
//  Created by Matthew Teece on 4/22/14.
//  Copyright (c) 2014 Matthew Teece. All rights reserved.
//


#import "PBWKSHttpContext.h"

#import <XCTest/XCTest.h>

@interface PBWKSHttpContextTest : XCTestCase

@end

@implementation PBWKSHttpContextTest

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

- (void)testCanAllocateHttpContext
{
    PBWKSHttpContext *context = [[PBWKSHttpContext alloc] init];
    
    NSDictionary *options = @{@"token" : @"1234567890",
                              @"user" : @"test",
                              @"email" : @"test@email.com"};

    
    [context setBaseUrl:@"http://www.unittest.com"];
    [context setRequestFormat:PBWKSHttpRequestFormatXML]; // PBWKSHttpRequestFormatJSON
    [context setVersion:1.0];
    [context setOptions:options];
    
    XCTAssertNotNil(context, @"PBWKSHttpContext cannot be nil.");
}

@end
