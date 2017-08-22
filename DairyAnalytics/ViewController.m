//
//  ViewController.m
//  DairyAnalytics
//
//  Created by Aswini Ramesh on 8/15/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.books = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)submitSensorDataButtonPressed:(id)sender {
    
    
    
    if([self.sensorIDTextField.text isEqualToString:BLANK_STRING] ||[self.sensorDataTextField.text isEqualToString:BLANK_STRING])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:SUBMIT_BUTTON_PROMPT preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:OK style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        sensorDataModel * sensorDataObtained = [[sensorDataModel alloc]init];
        sensorDataObtained.sensorID = self.sensorIDTextField.text;
        
        sensorDataObtained.sensorData = [[self.sensorDataTextField.text componentsSeparatedByString:@","]mutableCopy];
        
        NSLog(@"%@",sensorDataObtained.sensorData);
        
        [self postSensorDataToServer:sensorDataObtained];
        
        
    }

}

- (void)postSensorDataToServer:(sensorDataModel*) sensorDataObtained{
    
    [[SensorWebServices sharedInstance]  postSensorData:sensorDataObtained andCompletion:^(NSMutableArray *arr, NSError *error){
        
        if (error)
        {
            NSLog(@"error code: %@",[error localizedDescription] );

            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                           message:WEBSERVICE_ERROR_MESSAGE                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:OK style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            return;
            
        }
        else
        {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                           message:WEBSERVICE_SUCCESS_MESSAGE                                                                    preferredStyle:UIAlertControllerStyleAlert];
           
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:OK style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];
            return;
                                  }
        
    }];
    
}

- (IBAction)showCharts:(id)sender {
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    
    [textField resignFirstResponder];
    return YES;
}
@end
