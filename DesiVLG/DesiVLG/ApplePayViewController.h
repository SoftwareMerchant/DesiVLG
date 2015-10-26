//
//  ViewController.h
//  PayDemo
//
//  Created by Chris Beauchamp on 10/7/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <PassKit/PassKit.h>
#import <sqlite3.h>
#import "DBManager.h"

@interface ApplePayViewController : UIViewController
<MFMailComposeViewControllerDelegate,PKPaymentAuthorizationViewControllerDelegate>

@property (nonatomic) float subtotal;
@property (nonatomic) float tax;

@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *itemArray;
@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UITextField *phoneInput;
@property (weak, nonatomic) IBOutlet UIButton *applePayBtn;
@property (weak, nonatomic) IBOutlet UIButton *payLaterBtn;

@end

