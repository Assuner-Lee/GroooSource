//
//  GROrderList.m
//  GroooSource
//
//  Created by Assuner on 2017/2/28.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GROrderList.h"

@implementation GRFood

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"foodCount": @"count",
             @"foodName": @"name"
            };
}

@end


@implementation GROrder

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"userAddress": @"address",
             @"orderDetail": @"detail",
             @"orderID": @"order_id",
             @"cost": @"price",
             @"userRating": @"rating",
             @"userRemark": @"rating_remark",
             @"shop": @"seller",
             @"orderStatus": @"status",
             @"placeOrderTime": @"time",
             @"userName": @"username"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"orderDetail": @"GRFood"};
}

#pragma - getter

- (CGFloat)orderCellHight {
    if (!_orderCellHight) {
        if (_isSpread) {
            return 30 * _orderDetail.count + 140;
        } else {
            return 140;
        }
    } else {
        return _orderCellHight;
    }
}

- (CGFloat)orderCellMaxHight {
   return 30 * _orderDetail.count + 140;
}

@end


@implementation GROrderList

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"dataArray": @"GROrder"};
}

@end
