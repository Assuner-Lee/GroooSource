//
//  GRPlaceOrderRequest.h
//  GroooSource
//
//  Created by Assuner on 2017/4/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRNetRequestObject.h"

@interface GRPlaceOrderRequest : GRNetRequestObject

- (instancetype)initWithShopID:(NSUInteger)shopID ordersParams:(NSArray *)orderParams;

@end
