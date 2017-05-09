//
//  GRBuildingListRequest.m
//  GroooSource
//
//  Created by Assuner on 2017/5/9.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRBuildingListRequest.h"

@implementation GRBuildingListRequest

- (instancetype)init {
    if (self = [super init]) {
        self.requestPath = API_BUILDING_LIST;
        self.httpMethod = GRHTTPMethodGet;
        self.modelClassName = @"GRListTypeModel";
    }
    return self;
}

@end
