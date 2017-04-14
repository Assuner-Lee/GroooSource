//
//  GRMenuListRequest.m
//  GroooSource
//
//  Created by Assuner on 2017/3/23.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRMenuListRequest.h"

@implementation GRMenuListRequest

- (instancetype)initWithShopID:(NSUInteger)shopID {
    if (self = [super init]) {
        self.requestPath = [NSString stringWithFormat:API_MENU_LIST_F, shopID];
        self.httpMethod = GRHTTPMethodGet;
        self.modelClassName = @"GRMenuList";
    }
    return self;
}

@end
