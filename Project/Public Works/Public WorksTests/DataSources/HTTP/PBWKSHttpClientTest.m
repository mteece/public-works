//
//  PBWKSHttpClientTest.m
//  Public Works
//
//  Created by Matthew Teece on 4/13/14.
//  Copyright (c) 2014 Matthew Teece. All rights reserved.
//

#import "PBWKSHttpClient.h"
#import "PBWKSHttpContext.h"
#import "AFHTTPSessionManager.h"

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
    PBWKSHttpContext *context = [[PBWKSHttpContext alloc] init];
    
    NSDictionary *options = @{@"token" : @"1234567890",
                              @"user" : @"test",
                              @"email" : @"test@email.com"};
    
    
    [context setBaseUrl:@"http://www.unittest.com"];
    [context setRequestFormat:PBWKSHttpRequestFormatJSON];
    [context setVersion:1.0];
    [context setOptions:options];
    
    PBWKSHttpClient *client = [PBWKSHttpClient sharedPBWKSHttpClient];
    [client registerContext:context];
    
    XCTAssertNotNil(client, @"PBWKSHttpClient cannot be nil.");
    XCTAssertNotNil([client httpSessionManager], @"PBWKSHttpClient httpSessionManager instance cannot be nil.");
    
}

- (void)testClientCanPostData
{
    // POST is Content-Type: application/x-www-form-urlencoded
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSDictionary *credentials = @{
                                  @"email" : @"test@email.com",
                                  @"password" : @"password",
                                  @"device" : @"Test iPhone",
                                  @"device_type": @"iPhone",
                                  @"device_identifier": @"123456789"
                                  };

    
    PBWKSHttpContext *context = [[PBWKSHttpContext alloc] init];
    
    NSDictionary *options = @{@"token" : @"1234567890",
                              @"user" : @"test",
                              @"email" : @"test@email.com"};
    
    
    [context setBaseUrl:@"http://requestb.in/"];
    [context setRequestFormat:PBWKSHttpRequestFormatXML];
    [context setVersion:1.0];
    [context setOptions:options];
    
    PBWKSHttpClient *client = [PBWKSHttpClient sharedPBWKSHttpClient];
    [client registerContext:context];
    
    [[client httpSessionManager] POST:@"1cwudx61" parameters:credentials success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@", responseObject);
        XCTAssertTrue(YES, "Success");
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        XCTAssertFalse(YES, @"Failed");
        dispatch_semaphore_signal(semaphore);
    }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];

}

@end
