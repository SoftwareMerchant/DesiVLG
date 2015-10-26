//
//  AddAddressViewController.h
//  DesiVLG
//
//  Created by Yike Xue on 10/15/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddressDelegate;

@interface AddAddressViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UITextField *noteField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *stateField;
@property (weak, nonatomic) IBOutlet UITextField *zipField;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@property (nonatomic, weak) id<AddressDelegate> delegate;

@end

@protocol AddressDelegate <NSObject>

- (void)addAddressSuccess;

@end