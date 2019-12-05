//
//  ARCityAirQualityController.h
//  AirQualityObjC
//
//  Created by Aaron Shackelford on 12/4/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARCityAirQuality.h"

NS_ASSUME_NONNULL_BEGIN

@interface ARCityAirQualityController : NSObject

//self note -- these are cascading down each array to drill deeper and find city data
+(void)fetchSupportedCountries:(void(^) (NSArray<NSString *> *_Nullable))completion;

+(void)fetchSupportedStatesInCountry:(NSString *)country
                          completion:(void(^) (NSArray<NSString *> *_Nullable))completion;
+(void)fetchSupportedCitiesInState:(NSString *)state
                           country:(NSString *)country
                        completion:(void(^) (NSArray<NSString *> *_Nullable))completion;
+(void)fetchDataForCity:(NSString *)city
                  state:(NSString *)state
                country:(NSString *)country
             completion:(void(^) (ARCityAirQuality *_Nullable))completion;
//oh that last one looks pretty
@end

NS_ASSUME_NONNULL_END
