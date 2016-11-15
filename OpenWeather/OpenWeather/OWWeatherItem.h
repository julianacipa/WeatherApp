//
//  OWWeatherItem.h
//  OpenWeather
//
//  Created by Juliana Cipa on 02/11/2016.
//  Copyright © 2016 JC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWWeatherItem : NSObject

@property (nonnull, copy) NSString *dateText;
@property (nonnull, copy) NSString *iconName;
@property (nonnull, strong) NSNumber *windDegree;
@property (nonnull, strong) NSNumber *temp;

- (instancetype __nonnull)initWithDictionary:(NSDictionary * __nullable)paramDictionary NS_DESIGNATED_INITIALIZER;

-(NSString *)readableWeatherDate;
-(NSString *)readableWeatherTime;

@end
