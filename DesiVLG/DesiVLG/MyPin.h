//
//  MyPin.h
//  RamsHeadGroup
//
//  Created by Yike Xue on 6/28/15.
//  Copyright (c) 2015 Yike Xue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MyPin : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (id)initWithCoordinate2D:(CLLocationCoordinate2D)dinate
                    tittle:(NSString*)title subtitle:(NSString*)subtitle;

@property (nonatomic, copy)UIButton* rightButton;

@end
