//
//  sensorDataModel.h
//  DairyAnalytics
//
//  Created by Aswini Ramesh on 8/15/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sensorDataModel : NSObject

@property (strong, nonatomic) NSString* sensorID;
@property (strong, nonatomic) NSMutableArray* sensorData;



@end
