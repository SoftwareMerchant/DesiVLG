//
//  ViewController.m
//  DesiVLG
//
//  Created by Yike Xue on 10/6/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import "ViewController.h"
#import "AddAddressViewController.h"
#import "AppDelegate.h"


@interface ViewController () <AddressDelegate>
@property (nonatomic,retain) CLLocationManager* locationManager;
@property (nonatomic,strong) CLGeocoder *geocoder;
@property (nonatomic) bool delivery;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ScreenLaunch.png"]];
    self.delivery = NO;
    [self.deliveryBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.pickUpBtn.enabled = NO;
//    self.deliveryBtn.enabled = YES;
    self.annotations = [[NSMutableArray alloc] initWithCapacity:10];
    // Do any additional setup after loading the view from its nib.
    _geocoder=[[CLGeocoder alloc]init];
    [self location];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapPickup:(id)sender {
    if(self.delivery){
        self.pickUpBtn.backgroundColor = self.deliveryBtn.backgroundColor;
        self.pickUpBtn.tintColor = [UIColor whiteColor];
        [self.pickUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.pickUpBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:26.0];
        self.deliveryBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trans.png"]];
        self.deliveryBtn.tintColor = [UIColor darkGrayColor];
        [self.deliveryBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.deliveryBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:25.0];
        self.pickUpBtn.enabled = NO;
//        self.deliveryBtn.enabled = YES;
    }
    self.delivery = !self.delivery;
}

- (IBAction)tapDelivery:(id)sender {
    if(!self.delivery){
        self.deliveryBtn.backgroundColor = self.pickUpBtn.backgroundColor;
        self.deliveryBtn.tintColor = [UIColor whiteColor];
        [self.deliveryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.deliveryBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:26.0];
        self.pickUpBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trans.png"]];
        self.pickUpBtn.tintColor = [UIColor darkGrayColor];
        [self.pickUpBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.pickUpBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:25.0];
//        self.deliveryBtn.enabled = NO;
        self.pickUpBtn.enabled = YES;
        self.delivery = !self.delivery;
    }else{
        AddAddressViewController *addressController = [[AddAddressViewController alloc]  initWithNibName:@"AddAddressViewController" bundle:nil];
        addressController.delegate = self;
        [self presentViewController:addressController animated:YES completion:nil];
    }
}

- (IBAction)tapNow:(id)sender {
    self.orderTimeLabel.text = @"Get Your Meal ASAP";
    
    self.laterBtn.backgroundColor = [UIColor lightGrayColor];
    [self.laterBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.nowBtn.backgroundColor = self.orderTimeLabel.backgroundColor;
    [self.nowBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    self.nowBtn.enabled = NO;
    self.nowBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:35.0];
    self.laterBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:35.0];
    self.currentOrderDateTime = nil;
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    delegate.myOrderOptions.time = nil;
}

-(void)location{
    //code the address
    [_geocoder geocodeAddressString:@"4527 Baltimore Ave, Philadelphia, PA 19143" completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *clPlacemark=[placemarks firstObject];
        MKPlacemark *mkplacemark=[[MKPlacemark alloc]initWithPlacemark:clPlacemark];
        self.destination = mkplacemark;
        [self.annotations addObject:mkplacemark];
        [self addAnnotation];
    }];
}

#pragma mark AddPin
-(void)addAnnotation{
    CLLocationCoordinate2D location =self.destination.coordinate;
    MyPin *annotation=[[MyPin alloc]init];
    annotation.title=@"Desi Village Indian Restaurant";
    annotation.subtitle=@"4527 Baltimore Ave, Philadelphia, PA 19143";
    annotation.coordinate=location;
    
    //    float maxLat,minLat;
    //    float maxLong,minLong;
    //    if(_locationManager.location.coordinate.latitude > location.latitude){
    //        maxLat = _locationManager.location.coordinate.latitude;
    //        minLat = location.latitude;
    //    }else{
    //        minLat = _locationManager.location.coordinate.latitude;
    //        maxLat = location.latitude;
    //    }
    //    if(_locationManager.location.coordinate.longitude > location.longitude){
    //        maxLong = _locationManager.location.coordinate.longitude;
    //        minLong = location.longitude;
    //    }else{
    //        minLong = _locationManager.location.coordinate.longitude;
    //        maxLong = location.longitude;
    //    }
    
    MKCoordinateRegion region = _mapView.region;
    region.center = location;
    region.span.latitudeDelta = 0.01;//(maxLat - minLat) * 3;
    //    if((region.span.latitudeDelta < 0.0001 && region.span.latitudeDelta > 0) || (region.span.latitudeDelta < 0 && region.span.latitudeDelta > -0.0001)){
    //        region.span.latitudeDelta = 0.1;
    //    }
    region.span.longitudeDelta = 0.01;//(maxLong - minLong) * 3;
    //    if((region.span.longitudeDelta < 0.0001 && region.span.longitudeDelta > 0) ||(region.span.longitudeDelta < 0 && region.span.longitudeDelta > -0.0001)){
    //        region.span.longitudeDelta = 0.1;
    //    }
    //
    [self.mapView setRegion:region animated:YES];
    [self.mapView addAnnotation:annotation];
    [self.mapView selectAnnotation:annotation animated:YES];
    
}


- (IBAction)tapSelectItemsBtn:(id)sender {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if(self.delivery && delegate.myOrderOptions.destination == nil){
        AddAddressViewController *addressController = [[AddAddressViewController alloc]  initWithNibName:@"AddAddressViewController" bundle:nil];
        addressController.delegate = self;
        [self presentViewController:addressController animated:YES completion:nil];
    }else{
        [self performSegueWithIdentifier:@"showItemsMenu" sender:self];
    }
    
}

- (void)addAddressSuccess{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if(delegate.myOrderOptions.destination != nil){
        [self performSegueWithIdentifier:@"showItemsMenu" sender:self];
    }
}


-(IBAction)backToMainView: (UIStoryboardSegue *)segue {
    DateAndTimeViewController *dateTimeVCObject = segue.sourceViewController;
    [self setCurrentOrderDateTime:dateTimeVCObject.currentOrderDateTimeObject];
    if(!(self.currentOrderDateTime == nil)) {
        NSString *labelText = [NSString stringWithFormat:@"On %@, %@ @ %d:%d %@", self.currentOrderDateTime.selectedDay,self.currentOrderDateTime.selectedWeekDay,self.currentOrderDateTime.hours,self.currentOrderDateTime.minutes,self.currentOrderDateTime.amPM];
        NSLog(@"Object present");
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        delegate.myOrderOptions.time = self.currentOrderDateTime;
        self.orderTimeLabel.text = labelText;
        self.nowBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:35.0];
        self.nowBtn.backgroundColor = [UIColor lightGrayColor];
        [self.nowBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.laterBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:35.0];
        self.laterBtn.backgroundColor = self.orderTimeLabel.backgroundColor;
        [self.laterBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        self.nowBtn.enabled = YES;
    } else {
        NSLog(@"Object not present");
        self.orderTimeLabel.text = @"Get Your Meal ASAP";
        
        self.laterBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:35.0];
        self.laterBtn.backgroundColor = [UIColor lightGrayColor];
        [self.laterBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.nowBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:35.0];
        self.nowBtn.backgroundColor = self.orderTimeLabel.backgroundColor;
        [self.nowBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        self.nowBtn.enabled = NO;
    }
}
@end
