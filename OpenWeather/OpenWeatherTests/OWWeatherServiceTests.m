//
//  OWWeatherServiceTests.m
//  OpenWeather
//
//  Created by Juliana Cipa on 02/11/2016.
//  Copyright © 2016 JC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OWWeatherService.h"

@interface OWWeatherServiceTests : XCTestCase

@end

@implementation OWWeatherServiceTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testGetLondonWeatherItem {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Test London Weather Items"];
    
    [OWWeatherService getFiveDaysLondonWeatherWithCompletionHandler:^(NSArray *weatherItems, NSError *error) {
        XCTAssertNil(error, @"there should not be an error");
        XCTAssertNotNil(weatherItems, @"weather items should not be nil");
        XCTAssertTrue(weatherItems.count == 40, @"there should be 40 weather items");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:60 handler:nil];
}

@end
