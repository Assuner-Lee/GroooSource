//
//  GROperateOrderStatusRequest.m
//  GroooSource
//
//  Created by Assuner on 2017/5/9.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GROperateOrderStatusRequest.h"

@interface GROperateOrderStatusRequest ()

@property (nonatomic, strong) GROrder *order;

@property (nonatomic, assign) GROrderStatus toStatus;

@end

@implementation GROperateOrderStatusRequest

- (instancetype)initWithOrder:(GROrder *)order  {
    if (self = [super init]) {
        _order = order;
        self.requestPath = [NSString stringWithFormat:API_ORDER_STATUS_F, order.shop.shopID];
        self.httpMethod = GRHTTPMethodPut;
        
        if (order.orderStatus == GROrderStatusNotTaked) {
            _toStatus = GROrderStatusCanceling;
        } else if (order.orderStatus ==  GROrderStatusTaked) {
            _toStatus = GROrderStatusDone;
        }
    }
    return self;
}

- (NSDictionary *)paramsDic {
    return @{
             @"order_id": _order.orderID,
             @"status": @(_toStatus).stringValue
            };
}

@end
