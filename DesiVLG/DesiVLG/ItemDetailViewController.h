//
//  ItemDetailViewController.h
//  DesiVLG
//
//  Created by Yike Xue on 10/9/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetailViewController : UIViewController
@property (strong, nonatomic) NSString *itemName;
@property (strong, nonatomic) NSDecimalNumber *itemPrice;
@property (nonatomic) int itemQuantity;

@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *q1Btn;
@property (weak, nonatomic) IBOutlet UIButton *q2Btn;
@property (weak, nonatomic) IBOutlet UIButton *q4Btn;
@property (weak, nonatomic) IBOutlet UIButton *q3Btn;

//@property (weak, nonatomic) IBOutlet UITextField *quantityInput;
@property (weak, nonatomic) IBOutlet UITextField *noteInput;

- (IBAction)addInCartTap:(id)sender;
@end
