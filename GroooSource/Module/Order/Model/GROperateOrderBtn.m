//
//  GROperateOrderBtn.m
//  GroooSource
//
//  Created by Assuner on 2017/3/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GROperateOrderBtn.h"

@implementation GROperateOrderBtn

- (void)setOrderStatus:(GROrderStatus)orderStatus {
    _orderStatus = orderStatus;
    self.hidden = NO;
    switch (orderStatus) {
        case GROrderStatusNotTaked: {
            [self setTitle:@"取消" forState: UIControlStateNormal];
            [self setBackgroundColor:[UIColor blueColor]];
            return;
        }
        
        case GROrderStatusTaked: {
            [self setTitle:@"确认" forState: UIControlStateNormal];
            [self setBackgroundColor:[UIColor redColor]];
            return;
        }
        
        case GROrderStatusDone: {
            [self setTitle:@"评价" forState: UIControlStateNormal];
            [self setBackgroundColor:[GRAppStyle mainColor]];
            return;
        }
        
        case GROrderStatusCanceled:
        case GROrderStatusCanceling:
        case GROrderStatusRefused:
        case GROrderStatusRated: {
            self.hidden = YES;
        }
    }
}

@end
