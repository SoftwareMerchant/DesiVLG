//
//  Address.m
//  DesiVLG
//
//  Created by Yike Xue on 10/15/15.
//  Copyright © 2015 Yike Xue. All rights reserved.
//

#import "Address.h"

@implementation Address
- (id)initWithAddress:(NSString*)addr Note:(NSString*)note City:(NSString*)city State:(NSString*)state Zip:(NSString*)zip{
    self=[super init];
    
    if(self){
        self.addr = addr;
        self.note = note;
        self.city = city;
        self.state = state;
        self.zip = zip;
    }
    
    return self;
    
}
@end
