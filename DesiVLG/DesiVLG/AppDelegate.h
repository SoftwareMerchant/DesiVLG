//
//  AppDelegate.h
//  DesiVLG
//
//  Created by Yike Xue on 10/6/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderOptions.h"

@class  DateAndTimeViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong, nonatomic) OrderOptions *myOrderOptions;

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) DateAndTimeViewController *animationViewController;

- (void)presentAnimationController:(UIButton *)sender;


@end

