//
//  OWWeatherItem.m
//  OpenWeather
//
//  Created by Juliana Cipa on 02/11/2016.
//  Copyright © 2016 JC. All rights reserved.
//

#import "OWWeatherItem.h"

@implementation OWWeatherItem

- (instancetype) init {
    return [self initWithDictionary:nil];
}

- (instancetype __nonnull)initWithDictionary:(NSDictionary * __nullable)paramDictionary {
    self = [super init];
    
    if(self) {
        _dateText = paramDictionary[@"dt_txt"];
        _iconName = ((NSDictionary *)((NSArray *)paramDictionary[@"weather"]).firstObject)[@"icon"];
        _temp = paramDictionary[@"main"][@"temp"];
        _windDegree = paramDictionary[@"wind"][@"deg"];
    }
    
    return self;
}

-(NSString *)readableWeatherDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date  = [dateFormatter dateFromString:self.dateText];
    
    [dateFormatter setDateFormat:@"EEEE, dd MMM"];
    
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    
    return formattedDate;
}

-(NSString *)readableWeatherTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date  = [dateFormatter dateFromString:self.dateText];
    
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    
    return formattedDate;
}

@end
