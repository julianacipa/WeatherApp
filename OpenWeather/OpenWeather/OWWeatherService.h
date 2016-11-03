//
//  OWWeatherService.h
//  OpenWeather
//
//  Created by Juliana Cipa on 02/11/2016.
//  Copyright © 2016 JC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWWeatherService : NSObject

+ (void)getFiveDaysLondonWeatherWithCompletionHandler:(void (^)(NSDictionary *, NSError *))handler;

@end
