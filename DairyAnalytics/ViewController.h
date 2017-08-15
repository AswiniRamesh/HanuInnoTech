//
//  ViewController.h
//  DairyAnalytics
//
//  Created by Aswini Ramesh on 8/15/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "SensorDefines.h"
#import "sensorDataModel.h"
#import "SensorWebServices.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *sensorIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *sensorDataTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitSensorDataButton;

@property (strong, nonatomic) NSMutableArray *books;

- (IBAction)submitSensorDataButtonPressed:(id)sender;

- (void)postSensorDataToServer:(sensorDataModel*) sensorDataObtained;

@end

