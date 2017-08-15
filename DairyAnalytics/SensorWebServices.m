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
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject: sdata.sensorID forKey:@"sensorID" ];
    [params setObject: sdata.sensorData forKey:@"sensorData" ];
    NSLog(@"JSON Dictionary with sensor data: %@", [params description]);
        
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    [policy setValidatesDomainName:NO];
    [policy setAllowInvalidCertificates:YES];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",nil];
    
    
    
    [manager POST:SERVER_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
        NSError *error = nil;
        NSMutableArray *arr = (NSMutableArray*)responseObject;
        
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
