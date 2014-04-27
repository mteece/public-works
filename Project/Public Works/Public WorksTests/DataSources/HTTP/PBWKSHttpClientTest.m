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

#import <AFNetworking/AFNetworking.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

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

- (void)testHttpClientWillUnregister
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
    XCTAssertEqual([client clientFormat], @"json", @"PBWKSHttpClient clientFormat expected 'json'.");
    
    [client unregisterContext];
    
    XCTAssertNil([client httpSessionManager], @"PBWKSHttpClient httpSessionManager instance expected nil.");
    XCTAssertNil([client clientFormat], @"PBWKSHttpClient clientFormat expected nil.");
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

- (void)testHttpClientWillGetResponseForDiscovery
{
    // create a mock of the AFHTTPClient:
    id mockClient = [OCMockObject mockForClass:[AFHTTPSessionManager class]];
    
    // mock data
    NSData *mockData = [@"{ \"changeset\":\"2011-02-03 14:18\", \"contact\":\"You can email or call for assistance api@mycity.org +1 (555) 555-5555\", \"key_service\":\"You can request a key here: http://api.mycity.gov/api_key/request\", \"endpoints\":[ { \"specification\":\"http://wiki.open311.org/GeoReport_v2\", \"url\":\"http://open311.mycity.gov/v2\", \"changeset\":\"2010-11-23 09:01\", \"type\":\"production\", \"formats\":[ \"text/xml\" ] }, { \"specification\":\"http://wiki.open311.org/GeoReport_v2\", \"url\":\"http://open311.mycity.gov/test/v2\", \"changeset\":\"2010-10-02 09:01\", \"type\":\"test\", \"formats\":[ \"text/xml\", \"application/json\" ] }, { \"specification\":\"http://wiki.open311.org/GeoReport_v3\", \"url\":\"http://open311.mycity.gov/v3\", \"changeset\":\"2011-02-03 14:18\", \"type\":\"test\", \"formats\":[ \"text/xml\", \"application/json\" ] } ] }" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *mockJSON = [NSJSONSerialization JSONObjectWithData:mockData options:0 error:&error];
    NSLog(@"JSON DIct: %@", mockData);
    
    [[[mockClient expect] andDo:^(NSInvocation *invocation) {
        
        // we define the sucess block:
        void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = nil;
        
        // Using NSInvocation, we get access to the concrete block function
        // that has been passed in by the actual test
        // the arguments for the actual method start with 2 (see NSInvocation doc)
        [invocation getArgument:&successBlock atIndex:4];
        
        // now we invoke the successBlock with some "JSON"...:
        successBlock(nil,
                     [NSDictionary dictionaryWithDictionary:mockJSON]
                     );
        
    }] POST:[OCMArg any] parameters:nil success:[OCMArg any] failure:[OCMArg any]];
    
    [mockClient POST:@"discovery.json" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        XCTAssertEqualObjects(
                             @"2011-02-03 14:18",
                             [responseObject objectForKey:@"changeset"],
                             @"Mock JSON"
                             );
        // Get the 'results' array
        if ([[responseObject objectForKey:@"endpoints"] isKindOfClass:[NSArray class]])
        {
            NSArray *array = [responseObject objectForKey:@"endpoints"];
            NSLog(@"results array: %@", array);
            XCTAssertEqual(3, [array count], @"Array should contain 3 object.");
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        XCTFail(@"Mock JSON failed.");
    }];

}

@end
