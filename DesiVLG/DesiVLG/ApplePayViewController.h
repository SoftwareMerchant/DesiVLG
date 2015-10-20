//
//  ViewController.h
//  PayDemo
//
//  Created by Chris Beauchamp on 10/7/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PassKit/PassKit.h>

@interface ApplePayViewController : UIViewController
<PKPaymentAuthorizationViewControllerDelegate>

@property (nonatomic) float subtotal;
@property (nonatomic) float tax;

- (IBAction)checkOut:(id)sender;

@end

