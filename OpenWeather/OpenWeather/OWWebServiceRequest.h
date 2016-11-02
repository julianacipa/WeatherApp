//
//  OWWebServiceRequest.h
//  OpenWeather
//
//  Created by Juliana Cipa on 02/11/2016.
//  Copyright © 2016 JC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WebServiceRequestHandler)(NSDictionary *responseData, NSError *error);
typedef void (^DataTaskHandler)(NSData *data, NSURLResponse *response, NSError *error);

@interface OWWebServiceRequest : NSObject

+ (void)startGetRequestWithCityId:(NSString *)cityId
                          handler:(WebServiceRequestHandler)handler;

@end
