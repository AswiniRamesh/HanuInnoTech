//
//  SensorBarChartViewController.h
//  DairyAnalytics
//
//  Created by Aswini Ramesh on 8/21/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Charts/Charts.h>
@interface SensorBarChartViewController : UIViewController<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet LineChartView *sensorBarChartView;

@end
