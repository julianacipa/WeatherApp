//
//  OWWeatherService.m
//  OpenWeather
//
//  Created by Juliana Cipa on 02/11/2016.
//  Copyright © 2016 JC. All rights reserved.
//

#import "OWWeatherService.h"
#import "OWWebServiceRequest.h"
#import "OWWeatherItem.h"

@implementation OWWeatherService

+ (void)getFiveDaysLondonWeatherWithCompletionHandler:(void (^)(NSArray *, NSError *))handler  {
    [OWWebServiceRequest startGetRequestWithCityId:@"2643743"
                                           handler:^(NSDictionary *response, NSError *error) {
                                               NSDictionary *allWeatherItemsDict = response[@"list"];
                                               NSMutableArray *weatherItems = [NSMutableArray array];
                                               
                                               for(NSDictionary *weatherItemDict in allWeatherItemsDict) {
                                                   OWWeatherItem *weatherItem = [[OWWeatherItem alloc] initWithDictionary:weatherItemDict];
                                                   
                                                   if(weatherItem) {
                                                       [weatherItems addObject:weatherItem];
                                                   }
                                               }
                                               
                                               if (handler) {
                                                   handler([weatherItems copy], error);
                                               }
                                         }];
}

@end
