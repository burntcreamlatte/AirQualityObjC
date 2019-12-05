//
//  ARCityAirQuality.m
//  AirQualityObjC
//
//  Created by Aaron Shackelford on 12/4/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

#import "ARCityAirQuality.h"
#import "ARWeather.h"
#import "ARPollution.h"

@implementation ARCityAirQuality

-(instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(ARWeather *)weather pollution:(ARPollution *)pollution
{
    self = [super init];
    if (self)
    {
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    return self;
}

@end


@implementation ARCityAirQuality (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *city = dictionary[@"city"];
    NSString *state = dictionary[@"state"];
    NSString *country = dictionary[@"country"];
    NSDictionary *currentConditions = dictionary[@"current"]; //goes to find "weather" AND "pollution"
    ARWeather *weather = [[ARWeather alloc] initWithDictionary:currentConditions[@"weather"]];
    ARPollution *pollution = [[ARPollution alloc] initWithDictionary:currentConditions[@"pollution"]];
    
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}

@end
