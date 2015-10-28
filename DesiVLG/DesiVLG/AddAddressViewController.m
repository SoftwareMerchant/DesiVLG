//
//  AddAddressViewController.m
//  DesiVLG
//
//  Created by Yike Xue on 10/15/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import "AddAddressViewController.h"
#import "AppDelegate.h"

@interface AddAddressViewController ()
@property (nonatomic,strong) CLGeocoder *geocoder;
@property (copy, nonatomic) MKPlacemark *destination;
@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.doneBtn.enabled = NO;
    
    UITapGestureRecognizer * tapGesturRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processTap)];
    [self.view addGestureRecognizer:tapGesturRecognizer];
    
    _geocoder=[[CLGeocoder alloc]init];
    
}

-(void)location{
    //form the address string
    NSString *addStr = [NSString stringWithFormat:@"%@, %@, %@ %@",self.addressField.text,self.cityField.text,self.stateField.text, self.zipField.text];
    //code the address
    [_geocoder geocodeAddressString:addStr completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *clPlacemark=[placemarks firstObject];
        MKPlacemark *mkplacemark=[[MKPlacemark alloc]initWithPlacemark:clPlacemark];
        self.destination = mkplacemark;
        if(error == nil && [self validAddress]){
            [self saveAddress];
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.delegate addAddressSuccess];
        }else{
            [self popOutWarning];
        }

    }];
    
}

- (void)popOutWarning{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                             message:@"The address is invalid or out of our delivery range, please try again!"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    //We add buttons to the alert controller by creating UIAlertActions:
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    [alertController addAction:actionCancel];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)processTap{
    //  [self.quantityInput resignFirstResponder];
    [self.addressField resignFirstResponder];
    [self.cityField resignFirstResponder];
    [self.noteField resignFirstResponder];
    [self.zipField resignFirstResponder];
    [self.stateField resignFirstResponder];
    
    if([self.addressField.text isEqual:@""] || [self.cityField.text isEqual:@""] || [self.stateField.text isEqual:@""] || [self.zipField.text isEqual:@""]){
        self.doneBtn.enabled = NO;
        self.doneBtn.alpha = 0.65;
    }else{
        self.doneBtn.enabled = YES;
        self.doneBtn.alpha = 1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didEndOnExit:(id)sender {
    [self resignFirstResponder];
    if([self.addressField.text isEqual:@""] || [self.cityField.text isEqual:@""] || [self.stateField.text isEqual:@""] || [self.zipField.text isEqual:@""]){
        self.doneBtn.enabled = NO;
        self.doneBtn.alpha = 0.65;
    }else{
        self.doneBtn.enabled = YES;
        self.doneBtn.alpha = 1;
    }
}

- (Boolean)validAddress{
    if(self.destination != nil){
        if([self.destination.location distanceFromLocation:self.restaurant.location] < 2414.0){
            //within 1.5mile
            return YES;
        }
    }
    NSLog(@"Delivery address out of range!!!");
    return NO;
}
- (void)saveAddress{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    OrderOptions *options = delegate.myOrderOptions;
    Address *addr = [[Address alloc] initWithAddress:self.addressField.text Note:self.noteField.text City:self.cityField.text State:self.stateField.text Zip:self.zipField.text];
    [options setDestination:addr];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)tapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tapDone:(id)sender {
    [self location];
}
@end
