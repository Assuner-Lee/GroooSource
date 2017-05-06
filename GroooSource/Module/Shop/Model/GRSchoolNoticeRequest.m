//
//  GRSchoolNoticeRequest.m
//  GroooSource
//
//  Created by Assuner on 2017/5/6.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRSchoolNoticeRequest.h"

@implementation GRSchoolNoticeRequest

- (instancetype)init {
    if (self = [super init]) {
        self.requestPath = API_SCHOOL_NOTICE;
        self.httpMethod = GRHTTPMethodGet;
    }
    return self;
}

@end
