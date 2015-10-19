//
//  OrderTableViewCell.h
//  DesiVLG
//
//  Created by Yike Xue on 10/16/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "DBManager.h"
@protocol CellUpdateDelegate;

@interface OrderTableViewCell : UITableViewCell
@property (nonatomic) float unitPrice;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *note;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;

@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *itemNoteField;

@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *upBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;

@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, weak) id<CellUpdateDelegate> delegate;
@end

@protocol CellUpdateDelegate <NSObject>

- (void)updateCart;

@end