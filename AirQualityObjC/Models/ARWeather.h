//
//  ARWeather.h
//  AirQualityObjC
//
//  Created by Aaron Shackelford on 12/4/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ARWeather : NSObject

//self note -- keep in mind: no pointers needed for primitives
@property (nonatomic, readonly) NSInteger temperature;



@end

NS_ASSUME_NONNULL_END
