//
//  CartViewController.h
//  DesiVLG
//
//  Created by Yike Xue on 10/16/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "DBManager.h"

@interface CartViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *taxLabel;

@property (weak, nonatomic) IBOutlet UILabel *subtotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkOutBtn;
@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *itemArray;

- (void)clearCart;
- (void)clearConfirm;
@end
