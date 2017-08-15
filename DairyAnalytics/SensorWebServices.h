//
//  SensorWebServices.h
//  DairyAnalytics
//
//  Created by Aswini Ramesh on 8/15/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "SensorDefines.h"
#import "sensorDataModel.h"

@interface SensorWebServices : NSObject


+ (SensorWebServices *)sharedInstance;


- (void)postSensorData:(sensorDataModel*) sdata andCompletion:(void(^)(NSMutableArray *arr, NSError *error))completion;


@end
