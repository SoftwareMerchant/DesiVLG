//
//  CartTableViewController.h
//  DesiVLG
//
//  Created by Yike Xue on 10/13/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "DBManager.h"

@interface CartTableViewController : UITableViewController

@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *itemArray;

@end
