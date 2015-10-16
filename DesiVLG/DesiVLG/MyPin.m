//
//  MyPin.m
//  RamsHeadGroup
//
//  Created by Yike Xue on 6/28/15.
//  Copyright (c) 2015 Yike Xue. All rights reserved.
//

#import "MyPin.h"

@implementation MyPin

- (id)initWithCoordinate2D:(CLLocationCoordinate2D)dinate
                    tittle:(NSString*)title subtitle:(NSString*)subtitle
{
    if(self = [super init])
    {
        _title = title;
        _subtitle=subtitle;
        _coordinate = dinate;
    }
    return self;
}


@end
