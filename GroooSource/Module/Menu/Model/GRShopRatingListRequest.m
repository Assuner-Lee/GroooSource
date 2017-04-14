//
//  GRShopRatingListRequest.m
//  GroooSource
//
//  Created by Assuner on 2017/3/30.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRShopRatingListRequest.h"

@implementation GRShopRatingListRequest

- (instancetype)initWithShopID:(NSUInteger)shopID {
    if (self = [super init]) {
        _shopID = shopID;
        self.requestPath = [NSString stringWithFormat:API_RATE_LIST_F, shopID];
        self.httpMethod = GRHTTPMethodGet;
        self.modelClassName = @"GRShopRatingList";
    }
    return self;
}

@end
