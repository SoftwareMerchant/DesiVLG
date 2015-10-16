//
//  MenuIndexViewController.h
//  DesiVLG
//
//  Created by Yike Xue on 10/8/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuIndexViewController : UIViewController
@property (strong, nonatomic) NSMutableArray *MenuCategory;
@property (strong, nonatomic) NSMutableDictionary *expSection;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end
