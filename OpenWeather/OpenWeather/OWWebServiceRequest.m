//
//  OWWebServiceRequest.m
//  OpenWeather
//
//  Created by Juliana Cipa on 02/11/2016.
//  Copyright © 2016 JC. All rights reserved.
//

#import "OWWebServiceRequest.h"

static NSString *const kEndPointForCity = @"http://api.openweathermap.org/data/2.5/forecast?appid=ad361a4ddaa26d8ac1ff29b40df4e3b8&units=metric&id=";

@implementation OWWebServiceRequest

#pragma mark - Private methods

+ (void)populateHandler:(WebServiceRequestHandler)handler
               withData:(NSData *)data
               andError:(NSError *)error {
    if (error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(nil, error);
        });
    } else {
        NSError *deserializationError = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&deserializationError];
        
        if (deserializationError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil, deserializationError);
            });
        } else {
            NSDictionary *responseDict = (NSDictionary *)jsonObject;
            
            if (responseDict) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(responseDict, nil);
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(nil, nil);
                });
            }
        }
    }
}

+ (NSMutableURLRequest *)requestForURL:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setHTTPMethod:@"GET"];
    
    return request;
}

+ (void)startRequest:(NSURLRequest *)request withHandler:(WebServiceRequestHandler)handler {
    DataTaskHandler dataTaskHandler = ^(NSData *data, NSURLResponse * __unused response, NSError *error) {
        [OWWebServiceRequest populateHandler:handler withData:data andError:error];
    };
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    [[sharedSession dataTaskWithRequest:request completionHandler:dataTaskHandler] resume];
}

#pragma mark - Public method

+ (void)startGetRequestWithCityId:(NSString *)cityId
                          handler:(WebServiceRequestHandler)handler {
    if (handler) {
        NSString *url = [NSString stringWithFormat:@"%@%@.json", kEndPointForCity, cityId];
        NSMutableURLRequest *request = [OWWebServiceRequest requestForURL:url];
        
        [OWWebServiceRequest startRequest:request withHandler:handler];
    }
}

@end
