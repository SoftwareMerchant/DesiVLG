//
//  LocationViewController.h
//  RamsHeadGroup
//
//  Created by Yike Xue on 6/29/15.
//  Copyright (c) 2015 Yike Xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyPin.h"

@interface LocationViewController : UIViewController

@property (copy, nonatomic) MKPlacemark *destination;
@property (nonatomic, strong) NSMutableArray *annotations;

@end
