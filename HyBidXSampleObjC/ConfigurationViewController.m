//
//  ConfigurationViewController.m
//  HyBidXSampleObjC
//
//  Created by Fares Ben Hamouda on 28.02.20.
//  Copyright © 2020 Fares Ben Hamouda. All rights reserved.
//

#import "ConfigurationViewController.h"
#import "Config.h"
#import <HyBidX/HyBidX.h>

@interface ConfigurationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFieldSDKToken;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPlacement;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserID;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAge;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewGender;

@end

@implementation ConfigurationViewController

NSArray* genders;

- (void)viewDidLoad {
    [super viewDidLoad];
    genders = [[NSArray alloc]initWithObjects:@"male", @"female", @"not set", nil];
    [self initialValues];
}

-(void) initialValues {
    Config* config = [Config sharedInstance];
    _textFieldSDKToken.text = config.sdkToken;
    _textFieldPlacement.text = config.placement;
    [_pickerViewGender selectRow:genders.count-1 inComponent:0 animated:false];
    
    NSDictionary* userData = [HyBidX userData];
    _textFieldUserID.text = userData[@"userID"];
    _textFieldAge.text = userData[@"age"];
    
    if (![userData[@"gender"] isEqual:@""]) {
        [_pickerViewGender selectRow:[genders indexOfObject:userData[@"gender"]] inComponent:0 animated:false];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController) {
        
        Config* config = [Config sharedInstance];
        if (![_textFieldSDKToken.text isEqual:[Config sharedInstance].sdkToken]) {
            config.sdkToken = _textFieldSDKToken.text;
            [HyBidX configureWith:config.sdkToken completion:nil];
        }
        if (![_textFieldPlacement.text isEqual:[Config sharedInstance].placement]) {
            config.placement = _textFieldPlacement.text;
        }
        if (![_textFieldUserID.text isEqual:@""]) {
            [HyBidX identifyUserWith:_textFieldUserID.text];
        }
        if (![_textFieldAge.text isEqual:@""]) {
            [HyBidX setUserAgeWith: [_textFieldAge.text intValue]];
        }
        if ([_pickerViewGender selectedRowInComponent:0] != genders.count-1) {
            [HyBidX setUserGenderWith:genders[ [_pickerViewGender selectedRowInComponent:0]]];
        }
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return genders.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return genders[row];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
