//
//  OWWeatherItemTests.m
//  OpenWeather
//
//  Created by Juliana Cipa on 02/11/2016.
//  Copyright © 2016 JC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OWWeatherItem.h"

@interface OWWeatherItemTests : XCTestCase

@property(nonatomic, nonnull, strong)OWWeatherItem *weatherItem;

@end

@implementation OWWeatherItemTests

- (void)setUp {
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"OWWeatherItem"
                                                                          ofType:@"json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:jsonPath
                                                     encoding:NSUTF8StringEncoding
                                                        error:NULL];
    NSError *error;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionaryInPath = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                     options:0
                                                                       error:&error];
    
    self.weatherItem = [[OWWeatherItem alloc] initWithDictionary:dictionaryInPath];
    
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInitWeatherItem {
    XCTAssertTrue([self.weatherItem.dateText isEqualToString:@"2016-11-03 00:00:00"]);
    XCTAssertTrue([self.weatherItem.iconName isEqualToString:@"01n"]);
    XCTAssertTrue([self.weatherItem.temp isEqualToNumber:@0.39]);
}

-(void)testWeatherReadableDate {
    XCTAssertTrue([[self.weatherItem readableWeatherDate] isEqualToString:@"Thursday, 03 Nov"]);
}

-(void)testWeatherReadableTime {
    XCTAssertTrue([[self.weatherItem readableWeatherTime] isEqualToString:@"00:00"]);
}

@end
