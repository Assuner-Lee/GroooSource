//
//  GRUserInfoRequest.m
//  GroooSource
//
//  Created by Assuner on 2017/5/5.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRUserInfoRequest.h"

@implementation GRUserInfoRequest

- (instancetype)init {
    if (self = [super init]) {
        self.httpMethod = GRHTTPMethodGet;
        self.modelClassName = @"GRUserInfoData";
    }
    return self;
}

@end
