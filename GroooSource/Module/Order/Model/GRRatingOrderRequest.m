//
//  GRRatingOrderRequest.m
//  GroooSource
//
//  Created by Assuner on 2017/5/11.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRRatingOrderRequest.h"

@interface GRRatingOrderRequest ()

@property (nonatomic, strong) GROrder *order;
@property (nonatomic, assign) CGFloat rating;
@property (nonatomic, strong) NSString *remark;

@end

@implementation GRRatingOrderRequest

- (instancetype)initWithOrder:(GROrder *)order rating:(CGFloat)rating remark:(NSString *)remark {
    if (self = [super init]) {
        _order = order;
        _rating = rating;
        _remark = remark;
        self.requestPath = API_USER_ORDER;
        self.httpMethod = GRHTTPMethodPost;
    }
    return self;
}

- (NSDictionary *)paramsDic {
    return @{
             @"order_id": _order.orderID,
             @"rating": @(_rating).stringValue,
             @"rating_remark": _remark
             };
}

@end
