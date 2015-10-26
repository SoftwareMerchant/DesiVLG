//
//  OrderInfo.h
//  DesiVLG
//
//  Created by Yike Xue on 10/15/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Address.h"

@interface OrderOptions : NSObject
@property (nonatomic) Address* destination;
@property (nonatomic) NSDate* date;
@end
