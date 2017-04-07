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
             @"building": @"校内6号楼(男生)",
             @"address": @"5150",
             @"detail": _orderParams
            };
}

@end
