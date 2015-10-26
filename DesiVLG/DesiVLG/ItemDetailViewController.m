//
//  ItemDetailViewController.m
//  DesiVLG
//
//  Created by Yike Xue on 10/9/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import "ItemDetailViewController.h"
#import <sqlite3.h>
#import "DBManager.h"

@interface ItemDetailViewController ()<UITextViewDelegate>

@property (nonatomic, strong) DBManager *dbManager;


@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Dish Details";
    self.itemLabel.text = [NSString stringWithFormat:@"%@",self.itemName];
    UIImage *img = [UIImage imageNamed:@"priceTag.png"];
    CGSize imgSize = self.priceLabel.frame.size;
    UIGraphicsBeginImageContext( imgSize );
    [img drawInRect:CGRectMake(0,0,imgSize.width,imgSize.height+5)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.priceLabel.backgroundColor = [UIColor colorWithPatternImage:newImage];
    self.priceLabel.text = [NSString stringWithFormat:@" %.2f",[self.itemPrice floatValue]];
    self.noteTextView.delegate = self;
    self.noteTextView.text = @"e.g. Less spicy. (Add food items via options above.)";
    self.noteTextView.textColor = [UIColor lightGrayColor];
    
    self.itemQuantity = 1;
    self.q1Btn.layer.masksToBounds = YES;
    self.q1Btn.layer.cornerRadius = 8;
    self.q2Btn.layer.masksToBounds = YES;
    self.q2Btn.layer.cornerRadius = 8;
    self.q3Btn.layer.masksToBounds = YES;
    self.q3Btn.layer.cornerRadius = 8;
    self.q4Btn.layer.masksToBounds = YES;
    self.q4Btn.layer.cornerRadius = 8;
    self.q1Btn.backgroundColor = [UIColor colorWithHue:0.44 saturation:0.42 brightness:0.15 alpha:1];
    self.q2Btn.backgroundColor = [UIColor colorWithHue:0.44 saturation:0.44 brightness:0.19 alpha:0.7];
    self.q3Btn.backgroundColor = [UIColor colorWithHue:0.44 saturation:0.44 brightness:0.19 alpha:0.7];
    self.q4Btn.backgroundColor = [UIColor colorWithHue:0.44 saturation:0.44 brightness:0.19 alpha:0.7];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ShoppingCart"];
//    NSString *removeSQL = @"drop table cart";
//    [self.dbManager executeQuery:removeSQL];
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS CART (ID INTEGER PRIMARY KEY AUTOINCREMENT, ITEM TEXT, QUANTITY INTEGER, PRICE FLOAT, NOTE TEXT);";
    [self.dbManager executeQuery:createSQL];
    
    UITapGestureRecognizer * tapGesturRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processTap)];
    [self.view addGestureRecognizer:tapGesturRecognizer];
}

-(void)processTap{
//  [self.quantityInput resignFirstResponder];
    [self.noteTextView resignFirstResponder];
    self.tipLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didEndOnExit:(id)sender {
    [self resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"e.g. Less spicy. (Add food items via options above.)"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"e.g. Less spicy. (Add food items via options above.)";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSString*)getNote{
    if ([self.noteTextView.text isEqualToString:@"e.g. Less spicy. (Add food items via options above.)"]){
        return @"";
    }else{
        return self.noteTextView.text;
    }
}

- (IBAction)addInCartTap:(id)sender {
    NSString *query = [NSString stringWithFormat: @"select * from CART where ITEM = '%@' AND NOTE = '%@'", self.itemName, [self getNote]];
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    NSArray *result = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    if (result != nil && [result count] > 0) {
        NSLog(@"Select query was executed successfully. Item %@ already exist", self.itemName);
        NSInteger indexOfQuantity = 2;//[self.dbManager.arrColumnNames indexOfObject:@"quantity"];
        int existQuantity = [[[result objectAtIndex:0] objectAtIndex:indexOfQuantity] intValue];
        NSInteger indexOfID = 0;//[self.dbManager.arrColumnNames indexOfObject:@"id"];
        int existID = [[[result objectAtIndex:0] objectAtIndex:indexOfID] intValue];
        //        self.itemQuantity = [self.quantityInput.text intValue];
        NSString *updateQuery = [NSString stringWithFormat: @"update CART set QUANTITY = %d WHERE ID = %d", self.itemQuantity + existQuantity,  existID];

        // Execute the query.
        [self.dbManager executeQuery:updateQuery];
        
        // If the query was successfully executed then pop the view controller.
        if (self.dbManager.affectedRows != 0) {
            NSLog(@"Update query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Cong" message:@"You'v added the item(s) successfully!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//            [alert show];
            self.tipLabel.text = @"You'v added the item(s) successfully!";
        }
        else{
            NSLog(@"Could not execute the query.");
            self.tipLabel.text = @"Could not add the item(s).";
        }

    }
    else{
        NSLog(@"New Item!");
//        self.itemQuantity = [self.quantityInput.text intValue];
        NSString *insertQuery = [NSString stringWithFormat: @"insert into CART values(NULL,'%@', %d, %f, '%@')", self.itemName,self.itemQuantity , [self.itemPrice floatValue],[self getNote]];
        // Execute the query.
        [self.dbManager executeQuery:insertQuery];
        
        // If the query was successfully executed then pop the view controller.
        if (self.dbManager.affectedRows != 0) {
            NSLog(@"AddToCart query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Cong" message:@"You'v added the item(s) successfully!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//            [alert show];
            self.tipLabel.text = @"You'v added the item(s) successfully!";
        }
        else{
            NSLog(@"Could not execute the query.");
            self.tipLabel.text = @"Could not add the item(s).";
        }
    }
    
    
}

- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.sqlite"];
}

- (IBAction)tap1:(id)sender {
    self.itemQuantity = 1;
    self.q1Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.42 brightness:0.15 alpha:1];
    self.q2Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.44 brightness:0.19 alpha:0.7];
    self.q3Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.44 brightness:0.19 alpha:0.7];
    self.q4Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.44 brightness:0.19 alpha:0.7];
}

- (IBAction)tap2:(id)sender {
    self.itemQuantity = 2;
    self.q2Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.42 brightness:0.15 alpha:1];
    self.q1Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.44 brightness:0.19 alpha:0.7];
    self.q3Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.44 brightness:0.19 alpha:0.7];
    self.q4Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.44 brightness:0.19 alpha:0.7];
}

- (IBAction)tap3:(id)sender {
    self.itemQuantity = 3;
    self.q3Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.42 brightness:0.15 alpha:1];
    self.q2Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.44 brightness:0.19 alpha:0.7];
    self.q1Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.44 brightness:0.19 alpha:0.7];
    self.q4Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.44 brightness:0.19 alpha:0.7];
}

- (IBAction)tap4:(id)sender {
    self.itemQuantity = 4;
    self.q4Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.42 brightness:0.15 alpha:1];
    self.q2Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.44 brightness:0.19 alpha:0.7];
    self.q3Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.44 brightness:0.19 alpha:0.7];
    self.q1Btn.backgroundColor = [UIColor colorWithHue:0.4 saturation:0.44 brightness:0.19 alpha:0.7];
}
@end
