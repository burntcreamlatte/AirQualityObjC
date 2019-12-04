//
//  ARCityAirQuality.h
//  AirQualityObjC
//
//  Created by Aaron Shackelford on 12/4/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
//self note -- import weather and pollution to allow new properties into class for the endpoints
@class ARWeather;
@class ARPollution;

NS_ASSUME_NONNULL_BEGIN

@interface ARCityAirQuality : NSObject

@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *state;
@property (nonatomic, copy, readonly) NSString *country;
@property (nonatomic, copy, readonly) ARWeather *weather;
@property (nonatomic, copy, readonly) ARPollution *pollution;

-(instancetype)initWithCity:(NSString *)city
                      state:(NSString *)state
                    country:(NSString *)country
                    weather:(ARWeather *)weather
                  pollution:(ARPollution *)pollution;

@end


@interface ARCityAirQuality (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
