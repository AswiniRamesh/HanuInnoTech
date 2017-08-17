//
//  SensorWebServices.m
//  DairyAnalytics
//
//  Created by Aswini Ramesh on 8/15/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import "SensorWebServices.h"

@implementation SensorWebServices


+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];
        
    });
    
    
    return _sharedInstance;
}


- (void)postSensorData:(sensorDataModel*) sdata andCompletion:(void(^)(NSMutableArray *arr, NSError *error))completion
{
    
    /*NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject: sdata.sensorID forKey:@"Sensor_ID" ];
    [params setObject: sdata.sensorData forKey:@"TotalData" ];
     NSLog(@"JSON Dictionary with sensor data: %@", [params description]);*/
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject: @"firstTopic" forKey:@"topic" ];
    [params setObject: @"random" forKey:@"message" ];
    NSLog(@"JSON Dictionary with sensor data: %@", [params description]);
        
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    [policy setValidatesDomainName:NO];
    [policy setAllowInvalidCertificates:YES];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",nil];

    
    [manager POST:KAFKA_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
        NSError *error = nil;
        NSMutableArray *arr = (NSMutableArray*)responseObject;
        
    
        NSLog(@"Response obtained: %@", [responseObject description]);

    
        
        if (!error)
        completion(arr, nil);
        else
        completion(nil, error);
        
    }
          failure:^(NSURLSessionTask *operation, NSError *error)
     
     {
         
         if (completion)
         completion(nil, error);
     }];
    
    
}
@end
