//
//  ARCityAirQualityController.m
//  AirQualityObjC
//
//  Created by Aaron Shackelford on 12/4/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

#import "ARCityAirQualityController.h"
#import "ARCityAirQuality.h"

//setting as static would be redundant since methods are static already
NSString *const baseURLString = @"https://api.airvisual.com/";
NSString *const versionComponent = @"v2";
NSString *const countryComponent = @"countries";
NSString *const stateComponent = @"states";
NSString *const cityComponent = @"cities";
NSString *const cityDetailsComponent = @"city";
NSString *const apiKey = @"de01d2be-add7-4a67-9157-f2312ed3ead8";


@implementation ARCityAirQualityController

+(void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    //self note -- have to use an NSURL to be able to append paths etc
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *countryURL = [versionURL URLByAppendingPathComponent:countryComponent];
    //self TODO; verify key
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    //self note -- need to create array for queryItems to avoid incorrectly formatted URL
    NSMutableArray<NSURLQueryItem *> *queryItems = [[NSMutableArray alloc] init];
    //self note -- adding apiKey query item  to array
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:countryURL resolvingAgainstBaseURL:true];
    [urlComponents setQueryItems:queryItems];
    NSURL *finalURL = [urlComponents URL];
    
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error : %@ : %@", error, [error localizedDescription]);
            return completion(nil); //self note -- able to use nil as we have a nullable completion
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (!data)
        {
            NSLog(@"Error: no data received : %@ : %@", error, [error localizedDescription]);
            return completion(nil);
        }
        //indented mostly to help "box in" the JSONSerialization portion of the code; easier for me to see/process personally
        NSDictionary *topLevelDict = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:&error];
        NSDictionary *dataDict = topLevelDict[@"data"];
        NSMutableArray *countries = [[NSMutableArray alloc] init];
        for (NSDictionary *countryDict in dataDict)
        {
            NSString *country = [[NSString alloc] initWithString:countryDict[@"country"]];
            [countries addObject:country];
        }
        completion(countries);
    }] resume];
    
}
+(void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *statesURL = [versionURL URLByAppendingPathComponent:stateComponent];
    
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [[NSMutableArray alloc] init];
    //self note -- ADD THEM IN THE CORRECT ORDER
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:statesURL resolvingAgainstBaseURL:true];
    [urlComponents setQueryItems:queryItems];
    NSURL *finalURL = [urlComponents URL];
    
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error : %@ : %@", error, [error localizedDescription]);
            return completion(nil);
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (!data)
        {
            NSLog(@"Error: no data received : %@ : %@", error, [error localizedDescription]);
            return completion(nil);
        }
        NSDictionary *topLevelDict = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:&error];
        NSDictionary *dataDict = topLevelDict[@"data"];
        NSMutableArray *states = [[NSMutableArray alloc] init];
        for (NSDictionary *stateDict in dataDict)
        {
            NSString *state = stateDict[@"state"];
            [states addObject:state];
        }
        completion(states);
    }] resume];
    
    
}
+(void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *citiesURL = [versionURL URLByAppendingPathComponent:cityComponent];
    
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [[NSMutableArray alloc] init];
    
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:citiesURL resolvingAgainstBaseURL:true];
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error : %@ : %@", error, [error localizedDescription]);
            return completion(nil);
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (!data)
        {
            NSLog(@"Error: no data received : %@ : %@", error, [error localizedDescription]);
            return completion(nil);
        }
        NSDictionary *topLevelDict = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:&error];
        NSDictionary *dataDict = topLevelDict[@"data"];
        NSMutableArray *cities = [[NSMutableArray alloc] init];
        for (NSDictionary *cityDict in dataDict)
        {
            NSString *city = cityDict[@"city"];
            [cities addObject:city];
        }
        completion(cities);
    }] resume];
    
}
+(void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(ARCityAirQuality * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *cityURL = [versionURL URLByAppendingPathComponent:cityDetailsComponent];
    
    NSURLQueryItem *cityQuery = [[NSURLQueryItem alloc] initWithName:@"city" value:city];
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [[NSMutableArray alloc] init];
    
    [queryItems addObject:cityQuery]; [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery]; [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:cityURL resolvingAgainstBaseURL:true];
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error : %@ : %@", error, [error localizedDescription]);
            return completion(nil);
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (!data)
        {
            NSLog(@"Error: no data received : %@ : %@", error, [error localizedDescription]);
            return completion(nil);
        }
        NSDictionary *topLevelDict = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:&error];
        NSDictionary *dataDict = topLevelDict[@"data"];
        
        ARCityAirQuality *localAQI = [[ARCityAirQuality alloc] initWithDictionary:dataDict];
        completion(localAQI);
    }] resume];
}

@end
