//
//  GROperateOrderBtn.m
//  GroooSource
//
//  Created by Assuner on 2017/3/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GROperateOrderBtn.h"
#import "GROperateOrderStatusRequest.h"
#import "GROrderListViewController.h"

@implementation GROperateOrderBtn

- (instancetype)init {
    if (self = [super init]) {
        [self addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setOrder:(GROrder *)order {
    _order = order;
    self.hidden = NO;
    switch (order.orderStatus) {
        case GROrderStatusNotTaked: {
            [self setTitle:@"取消" forState: UIControlStateNormal];
            [self setBackgroundColor:[GRAppStyle orangeColor]];
            return;
        }
        
        case GROrderStatusTaked: {
            [self setTitle:@"确认" forState: UIControlStateNormal];
            [self setBackgroundColor:[GRAppStyle mainColor]];
            return;
        }
        
        case GROrderStatusDone: {
            [self setTitle:@"评价" forState: UIControlStateNormal];
            [self setBackgroundColor:[GRAppStyle goldColor]];
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

- (void)action {
    if (!_order) {
        return;
    }
    if (_order.orderStatus == GROrderStatusNotTaked || _order.orderStatus == GROrderStatusTaked) {
        [MBProgressHUD gr_showProgress];
        [[[GROperateOrderStatusRequest alloc] initWithOrder:_order] startRequestComplete:^(id  _Nullable responseObject, NSError * _Nullable error) {
            [MBProgressHUD gr_hideProgress];
            if (error) {
                [MBProgressHUD gr_showFailure:@"操作失败!"];
                return;
            }
            [MBProgressHUD gr_showSuccess:@"操作成功!"];
            [MBProgressHUD gr_showSuccess:@"更新状态!"];
            [(GROrderListViewController *)([GRRouter hostViewController].topViewController) startRequest];
        }];
    }
}

@end
