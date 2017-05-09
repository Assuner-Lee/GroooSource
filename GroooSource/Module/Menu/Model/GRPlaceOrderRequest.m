//
//  GRPlaceOrderRequest.m
//  GroooSource
//
//  Created by Assuner on 2017/4/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRPlaceOrderRequest.h"

@interface GRPlaceOrderRequest ()

@property (nonatomic, strong) NSArray *orderParams;

@end


@implementation GRPlaceOrderRequest

- (instancetype)initWithShopID:(NSUInteger)shopID ordersParams:(NSArray *)orderParams {
    if (self = [super init]) {
        self.requestPath = [NSString stringWithFormat:API_PLACE_ORDER_F, shopID];
        self.httpMethod = GRHTTPMethodPost;
        _orderParams = orderParams;
    }
    return self;
}

- (NSDictionary *)paramsDic {
    return @{
             @"building": [GRUserManager sharedManager].currentUser.building.length ? [GRUserManager sharedManager].currentUser.building : @"暂无楼栋",
             @"address": [GRUserManager sharedManager].currentUser.address.length ? [GRUserManager sharedManager].currentUser.address : @"暂无地址",
             @"detail": _orderParams
            };
}

@end
