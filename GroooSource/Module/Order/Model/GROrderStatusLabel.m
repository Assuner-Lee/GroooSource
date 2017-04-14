//
//  GROrderStatusLabel.m
//  GroooSource
//
//  Created by Assuner on 2017/3/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GROrderStatusLabel.h"

@implementation GROrderStatusLabel

- (void)setOrderStatus:(GROrderStatus)orderStatus {
    _orderStatus = orderStatus;
    switch (orderStatus) {
        case GROrderStatusNotTaked: {
            self.textColor = [UIColor orangeColor];
            self.text = @"未接单";
            return;
        }
            
        case GROrderStatusTaked: {
            self.textColor = [GRAppStyle mainColor];
            self.text = @"已接单";
            return;
        }
            
        case GROrderStatusCanceling: {
            self.textColor = [UIColor redColor];
            self.text = @"退单中";
            return;
        }
            
        case GROrderStatusCanceled: {
            self.textColor = [UIColor lightGrayColor];
            self.text = @"已退单";
            return;
        }
            
        case GROrderStatusRefused: {
            self.textColor = [UIColor lightGrayColor];
            self.text = @"取消单";
            return;
        }
            
        case GROrderStatusDone: {
            self.textColor = [GRAppStyle mainColor];
            self.text = @"已完成";
            return;
        }
        
        case GROrderStatusRated: {
            self.textColor = [UIColor lightGrayColor];
            self.text = @"已评价";
            return;
        }
    }
}

@end
