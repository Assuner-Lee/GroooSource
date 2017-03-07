//
//  GROrderListRequest.m
//  GroooSource
//
//  Created by Assuner on 2017/2/28.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GROrderListRequest.h"

@implementation GROrderListRequest

- (instancetype)init {
    if (self = [super init]) {
        self.requestPath = API_USER_ORDER;
        self.httpMethod = GRHTTPMethodGet;
        self.modelClassName = @"GROrderList";
    }
    return self;
}

@end
