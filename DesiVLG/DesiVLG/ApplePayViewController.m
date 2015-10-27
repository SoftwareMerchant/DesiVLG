//
//  ViewController.m
//  PayDemo
//
//  Created by Chris Beauchamp on 10/7/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

#import "ApplePayViewController.h"
#import "AppDelegate.h"

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
        request.supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkDiscover,PKPaymentNetworkVisa];
        request.merchantIdentifier = @"merchant.com.softwaremerchant.DesiVLG";
        request.merchantCapabilities = PKMerchantCapabilityEMV | PKMerchantCapability3DS;

        if([PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:@[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa, PKPaymentNetworkDiscover]]) {
//            PKPaymentAuthorizationViewController *vc = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
//            vc.delegate = self;
//            [self presentViewController:vc animated:YES completion:nil];
            PKPaymentAuthorizationViewController *paymentPane = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
            paymentPane.delegate = self;
            [self presentViewController:paymentPane animated:TRUE completion:nil];
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Apple Pay Warning" message:[NSString stringWithFormat:@"Information incomplete!"] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
            NSLog(@"Cannot make payment with given information!");
        }
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
    self.applePayBtn.enabled = NO;
    self.payLaterBtn.enabled = NO;
    
    [self.payLaterBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    UITapGestureRecognizer * tapGesturRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processTap)];
    [self.view addGestureRecognizer:tapGesturRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)processTap{
    //  [self.quantityInput resignFirstResponder];
    [self.nameInput resignFirstResponder];
    [self.phoneInput resignFirstResponder];
    if([self.nameInput.text isEqualToString:@""] || [self.phoneInput.text isEqualToString:@""]){
        self.applePayBtn.enabled = NO;
        self.payLaterBtn.enabled = NO;
        [self.payLaterBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }else{
        self.applePayBtn.enabled = YES;
        self.payLaterBtn.enabled = YES;
        [self.payLaterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}


//Method writes a string to a text file
-(void) writeToTextFile{
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
        NSString *fileName = [NSString stringWithFormat:@"%@/newOrder.txt",
                          documentsDirectory];
    //create content
    NSMutableString *content = [[NSMutableString alloc] init];
    [content appendFormat:@"Order From %@(Phone:%@).\n\n",self.nameInput.text,self.phoneInput.text];
    //Set order options
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    OrderOptions *options = delegate.myOrderOptions;
    if(options.destination == nil){
        [content appendString:@"Pick Up In Store.\n-------------------------"];
    }else{
        [content appendFormat:@"Delivery Address\n************************\nStreet:%@\nCity:%@\nState:%@\nZipcode:%@\nNote:%@\n-------------------------\n",options.destination.addr,options.destination.city,options.destination.state,options.destination.zip,options.destination.note];
    }
    NSDateFormatter *formatter;
    NSString        *dateString;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    dateString = [formatter stringFromDate:[NSDate date]];
    [content appendFormat:@"\nCurrent Date:%@\n-------------------------\n",dateString];
    if(options.time != nil){
        [content appendFormat:@"Want it on %@, %@ @ %d:%d %@", options.time.selectedDay,options.time.selectedWeekDay,options.time.hours,options.time.minutes,options.time.amPM];
    }else{
        [content appendString:@"Want it ASPS"];
    }
    
    [content appendString:@"Item(s)\n************************\n"];
    
    for(NSArray *item in self.itemArray){
        [content appendFormat:@"Name:%@\nQuantity:%d/nPrice:%.2f\nNote:%@\n+++++++++++++++++++++++++++++\n",[item objectAtIndex:1] ,[[item objectAtIndex:2] intValue], [[item objectAtIndex:3] floatValue], [item objectAtIndex:4]];
    }

    [content appendFormat:@"-------------------------\n\nSubtotal:%.2f\nTax:%.2f\nGrand Total:%.2f",self.subtotal,self.tax,self.subtotal+self.tax];
    
    //save content to the documents directory
    [content writeToFile:fileName
              atomically:NO
                encoding:NSStringEncodingConversionAllowLossy
                   error:nil];
    
}
- (IBAction)sendEmail:(id)sender {
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ShoppingCart"];
    // Form the query.
    NSString *query = @"select * from CART";
    
    // Get the results.
    if (self.itemArray != nil) {
        self.itemArray = nil;
    }
    self.itemArray = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    if(self.itemArray == nil || [self.itemArray count] == 0){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                                 message:@"Your Order Cart Is Empty!"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //We add buttons to the alert controller by creating UIAlertActions:
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
        [alertController addAction:actionCancel];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        [self EmailButtonAction];
    }
}

-(void)EmailButtonAction{
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller.navigationBar setBackgroundImage:[UIImage imageNamed:@"ScreenLaunch.png"] forBarMetrics:UIBarMetricsDefault];
        controller.navigationBar.tintColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        [controller setSubject:@"Order Email"];
        
        [controller setMessageBody:@"Here is an order!" isHTML:YES];
        [controller setToRecipients:[NSArray arrayWithObjects:@"yike_xue@softwaremerchant.com",nil]];
        [self writeToTextFile];
        NSArray *paths = NSSearchPathForDirectoriesInDomains
        (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        //make a file name to write the data to using the documents directory:
        NSString *fileName = [NSString stringWithFormat:@"%@/newOrder.txt",
                              documentsDirectory];
        NSData *myData = [NSData dataWithContentsOfFile:fileName];
        [controller addAttachmentData:myData mimeType:@"text/plain" fileName:@"newOrder"];
        [self presentViewController:controller animated:YES completion:NULL];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"alrt" message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil] ;
        [alert show];
    }
    
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
        NSString *removeSQL = @"drop table if exists cart";
        [self.dbManager executeQuery:removeSQL];
        NSLog(@"Your cart is clear!");
    }
    dispatch_after(0, dispatch_get_main_queue(), ^{
        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    });
}
@end
