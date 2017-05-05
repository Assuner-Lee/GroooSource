//
//  GRLoginResponse.m
//  GroooSource
//
//  Created by 李永光 on 2017/2/10.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRLoginResponse.h"

@implementation GRLoginData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"userID": @"id"};
}

@end


@implementation GRLoginResponse

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"loginData": @"data"};
}
@end
