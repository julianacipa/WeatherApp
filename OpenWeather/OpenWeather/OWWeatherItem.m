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
    }
    
    return self;
}

@end
