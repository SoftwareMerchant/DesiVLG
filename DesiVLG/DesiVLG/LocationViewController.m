//
//  LocationViewController.m
//  RamsHeadGroup
//
//  Created by Yike Xue on 6/29/15.
//  Copyright (c) 2015 Yike Xue. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface LocationViewController () <MKMapViewDelegate,CLLocationManagerDelegate>{
    MKMapView *_mapView;
}
@property (nonatomic,retain) CLLocationManager* locationManager;
@property (nonatomic,strong) CLGeocoder *geocoder;

@end

@implementation LocationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Location";
    self.annotations = [[NSMutableArray alloc] initWithCapacity:10];
    // Do any additional setup after loading the view from its nib.
    _geocoder=[[CLGeocoder alloc]init];
    [self location];
    [self initGUI];

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


#pragma mark map
-(void)initGUI{
    CGRect rect=[UIScreen mainScreen].bounds;
    _mapView=[[MKMapView alloc]initWithFrame:rect];
    [self.view addSubview:_mapView];

    _mapView.delegate=self;
//    //request for location service
//    _locationManager=[[CLLocationManager alloc]init];
//    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
//        [_locationManager requestWhenInUseAuthorization];
//    }
//    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//    _locationManager.delegate = self;
//     [_locationManager startUpdatingLocation];
//    //track the user's location
//    _mapView.userTrackingMode=MKUserTrackingModeFollow;
//
//    _mapView.mapType=MKMapTypeStandard;
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
    [_mapView setRegion:region animated:YES];
    [_mapView addAnnotation:annotation];
    [_mapView selectAnnotation:annotation animated:YES];
//    self.curSelectedPin = annotation;
    
//    CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(location.latitude+0.002, location.longitude-0.02);
//    MyPin *annotation1=[[MyPin alloc]init];
//    annotation1.title=@"Theater";
//    annotation1.subtitle=@"where we watch the films";
//    annotation1.coordinate=location1;
//    [_mapView addAnnotation:annotation1];
//    
//    CLLocationCoordinate2D location2=CLLocationCoordinate2DMake(location.latitude-0.01, location.longitude+0.02);
//    MyPin *annotation2=[[MyPin alloc]init];
//    annotation2.title=@"Bus station";
//    annotation2.subtitle=@"take a bus~~";
//    annotation2.coordinate=location2;
//    [_mapView addAnnotation:annotation2];
    
}

//delegate method of CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"didChangeAuthorizationStatus---%u",status);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didChangeAuthorizationStatusError----%@",error);
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"%@",userLocation);
    mapView.centerCoordinate = userLocation.location.coordinate;
//    show the region range
        MKCoordinateSpan span=MKCoordinateSpanMake(0.01, 0.01);
        MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
        [_mapView setRegion:region animated:true];
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView
//            viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    // If it's the user location, just return nil.
//    if ([annotation isKindOfClass:[MKUserLocation class]])
//        return nil;
//    
//    // Handle any custom annotations.
//    if ([annotation isKindOfClass:[MyPin class]])
//    {
//        // Try to dequeue an existing pin view first.
//        MKPinAnnotationView*   pinView = (MKPinAnnotationView*)[mapView
//                                                                 dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
//        
//        if (!pinView)
//        {
//            // If an existing pin view was not available, create one.
//            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
//                                             reuseIdentifier:@"CustomPinAnnotation"];
//            pinView.pinColor = MKPinAnnotationColorGreen;
//            pinView.animatesDrop = YES;
//            pinView.canShowCallout = YES;
//            
//            //CLLocationCoordinate2D location =self.destination.coordinate;
//            // Add a detail disclosure button to the callout.
//            UIButton* rightButton = [UIButton buttonWithType:
//                                     UIButtonTypeRoundedRect];
//            [rightButton setFrame:(CGRect){260,0,pinView.frame.size.height*0.8,pinView.frame.size.height*0.8}];
//            [rightButton setBackgroundImage:[UIImage imageNamed:@"navi.png"] forState:UIControlStateNormal];
//            [rightButton addTarget:self action:@selector(pinButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//            pinView.rightCalloutAccessoryView = rightButton;
//        }
//        else
//            pinView.annotation = annotation;
//        
//        return pinView;   
//    }   
//    
//    return nil;   
//}
//
//-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKPinAnnotationView *)view{
//    self.curSelectedPin = view.annotation;
//}
//
//-(void)pinButtonTapped:(id)sender
//{
//    //AnnotationViewController *ann1 =[sender superview];
//    //NSString *str = ann1.title;
//    MyPin *ann = self.curSelectedPin;
//    CLLocationCoordinate2D to =[ann coordinate];
//    CLLocationCoordinate2D from = _locationManager.location.coordinate;
//    NSLog(@"Go navigation!");
//    MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:from addressDictionary:nil]];
//    //destination position
//    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
//    currentLocation.name = @"current location";
//    toLocation.name = ann.title;
//    NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
//    
//    NSDictionary *options = @{
//                              MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
//                              MKLaunchOptionsMapTypeKey:
//                                  [NSNumber numberWithInteger:MKMapTypeStandard],
//                              MKLaunchOptionsShowsTrafficKey:@YES
//                              };
//    //Using apple map
//    [MKMapItem openMapsWithItems:items launchOptions:options];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
