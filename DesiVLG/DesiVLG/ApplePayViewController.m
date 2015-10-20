//
//  ViewController.m
//  PayDemo
//
//  Created by Chris Beauchamp on 10/7/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

#import "ApplePayViewController.h"

@interface ApplePayViewController ()

@end

@implementation ApplePayViewController

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
    NSLog(@"Payment was authorized: %@", payment);
    
    // do an async call to the server to complete the payment.
    // See PKPayment class reference for object parameters that can be passed
    BOOL asyncSuccessful = FALSE;
    
    // When the async call is done, send the callback.
    // Available cases are:
//    PKPaymentAuthorizationStatusSuccess, // Merchant auth'd (or expects to auth) the transaction successfully.
//    PKPaymentAuthorizationStatusFailure, // Merchant failed to auth the transaction.
//    
//    PKPaymentAuthorizationStatusInvalidBillingPostalAddress,  // Merchant refuses service to this billing address.
//    PKPaymentAuthorizationStatusInvalidShippingPostalAddress, // Merchant refuses service to this shipping address.
//    PKPaymentAuthorizationStatusInvalidShippingContact        // Supplied contact information is insufficient.

    if(asyncSuccessful) {
        completion(PKPaymentAuthorizationStatusSuccess);

        // do something to let the user know the status
        
        NSLog(@"Payment was successful");
        
//        [Crittercism endTransaction:@"checkout"];
    
    } else {
        completion(PKPaymentAuthorizationStatusFailure);
        
        // do something to let the user know the status

        NSLog(@"Payment was unsuccessful");
        
//        [Crittercism failTransaction:@"checkout"];
    }

}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
    NSLog(@"Finishing payment view controller");
    
    // hide the payment window
    [controller dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)checkOut:(id)sender
{
    // [Crittercism beginTransaction:@"checkout"];
    
    if([PKPaymentAuthorizationViewController canMakePayments]) {

        NSLog(@"Can make payments with Apple Pay!");
        
        PKPaymentRequest *request = [[PKPaymentRequest alloc] init];

        PKPaymentSummaryItem *widget1 = [PKPaymentSummaryItem summaryItemWithLabel:@"Subtotal"
                                                                          amount:[[NSDecimalNumber alloc] initWithFloat:self.subtotal]];
        
        PKPaymentSummaryItem *widget2 = [PKPaymentSummaryItem summaryItemWithLabel:@"Tax"
                                                                          amount:[[NSDecimalNumber alloc] initWithFloat:self.tax]];
        
        PKPaymentSummaryItem *total = [PKPaymentSummaryItem summaryItemWithLabel:@"Grand Total"
                                                                          amount:[[NSDecimalNumber alloc] initWithFloat:self.subtotal+self.tax]];

        request.paymentSummaryItems = @[widget1, widget2, total];
        request.countryCode = @"US";
        request.currencyCode = @"USD";
        request.supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa];
        request.merchantIdentifier = @"merchant.com.softwaremerchant.desiVLG";
        request.merchantCapabilities = PKMerchantCapabilityEMV;

        PKPaymentAuthorizationViewController *paymentPane = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
        paymentPane.delegate = self;
        [self presentViewController:paymentPane animated:TRUE completion:nil];
        
    } else {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Apple Pay Warning" message:[NSString stringWithFormat:@"Your device doesn't support Apple Pay service!"] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        NSLog(@"This device cannot make payments");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ScreenLaunch.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
