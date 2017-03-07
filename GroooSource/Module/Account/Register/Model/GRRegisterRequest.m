//
//  GRRegisterRequest.m
//  GroooSource
//
//  Created by Assuner on 2017/2/13.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRRegisterRequest.h"

@interface GRRegisterRequest ()

@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *password;


@end

@implementation GRRegisterRequest


- (instancetype)initWithMobile:(NSString *)mobile password:(NSString *)password {
    if (self = [super init]) {
        self.requestPath = API_USER_REGISTER;
        self.httpMethod = GRHTTPMethodPost;
        
        _mobile = mobile;
        _password = password;
    }
    return self;
}

#pragma - override

- (NSDictionary *)paramsDic {
    return @{
             @"username": _mobile,
             @"password": _password,
             @"school_id": @1
             };
}


@end
