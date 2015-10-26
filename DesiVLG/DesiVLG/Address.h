//
//  Address.h
//  DesiVLG
//
//  Created by Yike Xue on 10/15/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject
@property (nonatomic) NSString *addr;
@property (nonatomic) NSString *note;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *state;
@property (nonatomic) NSString *zip;

- (id)initWithAddress:(NSString*)addr Note:(NSString*)note City:(NSString*)city State:(NSString*)state Zip:(NSString*)zip;
@end
