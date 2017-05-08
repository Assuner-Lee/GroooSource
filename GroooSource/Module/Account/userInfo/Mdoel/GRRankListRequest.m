//
//  GRRankListRequest.m
//  GroooSource
//
//  Created by Assuner on 2017/5/8.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRRankListRequest.h"

@implementation GRRankListRequest

- (instancetype)init {
    if (self = [super init]) {
        self.requestPath = API_RANK_LIST;
        self.httpMethod = GRHTTPMethodGet;
        self.modelClassName = @"GRTuhaoRankList";
    }
    return self;
}

@end
