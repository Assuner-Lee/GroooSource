//
//  GRChangePasswordRequest.m
//  GroooSource
//
//  Created by Assuner on 2017/5/6.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRChangePasswordRequest.h"

@interface GRChangePasswordRequest ()

@property (nonatomic, strong) NSString *password;

@end


@implementation GRChangePasswordRequest

- (instancetype)initWithNewPassWord:(NSString *)password {
    if (self = [super init]) {
        self.requestPath = API_USER_REGISTER;
        self.httpMethod = GRHTTPMethodPut;
        _password = password;
    }
    return  self;
}

- (NSDictionary *)paramsDic {
    return @{@"newPassword": _password};
}

@end
