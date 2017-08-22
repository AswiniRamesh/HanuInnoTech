//
//  SensorBarChartViewController.m
//  DairyAnalytics
//
//  Created by Aswini Ramesh on 8/21/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import "SensorBarChartViewController.h"

@interface CubicLineSampleFillFormatter : NSObject <IChartFillFormatter>
{
}
@end

@implementation CubicLineSampleFillFormatter

- (CGFloat)getFillLinePositionWithDataSet:(LineChartDataSet *)dataSet dataProvider:(id<LineChartDataProvider>)dataProvider
{
    return -10.f;
}

@end


@interface SensorBarChartViewController ()

@end

@implementation SensorBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Dairy Analytics - Charts";

    
    _sensorBarChartView.delegate=self;
   
    //[_sensorBarChartView setViewPortOffsetsWithLeft:0.f top:20.f right:0.f bottom:0.f];
    _sensorBarChartView.backgroundColor = UIColor.whiteColor;
    
    _sensorBarChartView.chartDescription.enabled = NO;
    _sensorBarChartView.dragEnabled = YES;
    [_sensorBarChartView setScaleEnabled:YES];
    _sensorBarChartView.pinchZoomEnabled = NO;
    _sensorBarChartView.drawGridBackgroundEnabled = NO;
    _sensorBarChartView.maxHighlightDistance = 300.0;
    _sensorBarChartView.xAxis.enabled = NO;
    
    ChartYAxis *yAxis = _sensorBarChartView.leftAxis;
    yAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
    [yAxis setLabelCount:6 force:NO];
    yAxis.labelTextColor = UIColor.whiteColor;
    yAxis.labelPosition = YAxisLabelPositionInsideChart;
    yAxis.drawGridLinesEnabled = NO;
    yAxis.axisLineColor = UIColor.whiteColor;
    
    ChartXAxis *xAxis = _sensorBarChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionTopInside;
    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    xAxis.labelTextColor =UIColor.whiteColor;
    xAxis.drawAxisLineEnabled = NO;
    xAxis.drawGridLinesEnabled = YES;
    xAxis.centerAxisLabelsEnabled = YES;
    xAxis.granularity = 3600.0;
    
    _sensorBarChartView.rightAxis.enabled = NO;
    _sensorBarChartView.legend.form= ChartLegendFormLine;
    
    
    NSMutableArray *datapoints = [[NSMutableArray alloc]initWithObjects:@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@15,@16,@17,@18,@19,@20,@21,@22,@23,@24,@25,nil];
    NSMutableArray *values = [[NSMutableArray alloc]initWithObjects:@1,@2,@3,@4,@3,@2,@1,@2,@6,@6,@5,@3,@6,@7,@7,@6,@4,@3,@3,@5,@6,@5,@3,@2,@1,@0, nil];
   
    [self setBarChart:datapoints and:values];
   
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setBarChart:(NSMutableArray *)dataPoints and:(NSMutableArray *)values
{
    
    _sensorBarChartView.noDataText = @"No Data to Display";
    
    
    //X Axis  Values
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i=0;i<dataPoints.count;i++)
    {
        [xVals addObject:[dataPoints objectAtIndex:i]];
    }
    
    //Y Axis Values
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i=0;i<values.count;i++)
    {
        int val = [([values objectAtIndex:i])intValue];
        [yVals addObject:[[BarChartDataEntry alloc]initWithX:(double)i y:(double)val]];
    }
    
    LineChartDataSet *set1 = nil;
    if (_sensorBarChartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_sensorBarChartView.data.dataSets[0];
        set1.values = yVals;
        [_sensorBarChartView.data notifyDataChanged];
        [_sensorBarChartView notifyDataSetChanged];
    }
    else
    {
    set1 = [[LineChartDataSet alloc] initWithValues:yVals label:@"Sensor Values"];
    set1.mode = LineChartModeCubicBezier;

        
        set1.drawCubicEnabled = YES;
        set1.cubicIntensity = 0.1;
        set1.drawCirclesEnabled = NO;
        set1.lineWidth = 1.8;
        set1.circleRadius = 4.0;
        [set1 setCircleColor:UIColor.blueColor];
        set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        [set1 setColor:UIColor.whiteColor];
        set1.fillColor = UIColor.blueColor;
        set1.fillAlpha = 0.5f;
        set1.drawFilledEnabled = YES;
        set1.drawHorizontalHighlightIndicatorEnabled = NO;
        set1.fillFormatter = [[CubicLineSampleFillFormatter alloc] init];
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    
    
    _sensorBarChartView.data = data;
    
    
    }
     [_sensorBarChartView setNeedsDisplay];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
