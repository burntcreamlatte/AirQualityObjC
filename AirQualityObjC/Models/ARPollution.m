//
//  ARPollution.m
//  AirQualityObjC
//
//  Created by Aaron Shackelford on 12/4/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

#import "ARPollution.h"

@implementation ARPollution

-(instancetype)initWithInt:(NSInteger)aqi
{
    
    self = [super init];
    if (self) {
        _airQualityIndex = aqi;
    }
    return self;
}

@end


//self note -- we won't get a warning for initWithDictionary until we create the implementation WITH JSONConvertable extension; different bodies
@implementation ARPollution (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    //self TODO; verify correct aqi key
    NSInteger aqi = [dictionary[@"aqius"] intValue];
    return [self initWithInt:aqi];
}

@end
