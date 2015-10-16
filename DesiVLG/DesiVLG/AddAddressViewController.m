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

@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.doneBtn.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didEndOnExit:(id)sender {
    [self resignFirstResponder];
    if([self.addressField.text isEqual:@""] || [self.cityField.text isEqual:@""] || [self.stateField.text isEqual:@""] || [self.zipField.text isEqual:@""]){
        self.doneBtn.enabled = NO;
        self.doneBtn.alpha = 1;
    }else{
        self.doneBtn.enabled = YES;
        self.doneBtn.alpha = 0.75;
    }
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
    [self saveAddress];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
