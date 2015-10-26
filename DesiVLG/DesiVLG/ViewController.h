//
//  ViewController.h
//  DesiVLG
//
//  Created by Yike Xue on 10/6/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyPin.h"
#import "DateTime.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *pickUpBtn;
@property (weak, nonatomic) IBOutlet UIButton *deliveryBtn;

@property (copy, nonatomic) MKPlacemark *destination;
@property (nonatomic, strong) NSMutableArray *annotations;


@property (nonatomic) DateTime * currentOrderDateTime;
@end

