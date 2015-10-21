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

- (IBAction)checkOut:(id)sender;

@end

