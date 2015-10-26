//
//  DateTime.h
//  DesiVLG
//
//  Created by Nisarg Vora on 10/23/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTime : NSObject

@property (nonatomic) NSString* amPM;
@property (nonatomic) int hours;
@property (nonatomic) int minutes;
@property (nonatomic) NSNumber * selectedDay;
@property (nonatomic) NSString * selectedWeekDay;

@end
