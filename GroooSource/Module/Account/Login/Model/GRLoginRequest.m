//
//  GRLoginRequest.m
//  GroooSource
//
//  Created by Assuner on 2017/2/13.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRLoginRequest.h"

@interface GRLoginRequest ()

@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *password;

@end

@implementation GRLoginRequest

- (instancetype)initWithMobile:(NSString *)mobile password:(NSString *)password {
    if (self = [super init]) {
        self.requestPath = API_USER_LOGIN;
        self.httpMethod = GRHTTPMethodPost;
        self.modelClassName = @"GRLoginResponse";
        
        _mobile = mobile;
        _password = password;
    }
    return self;
}

#pragma - override

- (NSDictionary *)paramsDic {
    return @{
             @"username": _mobile,
             @"password": _password
            };
}

@end
