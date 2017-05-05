//
//  GRUserInfoData.m
//  GroooSource
//
//  Created by Assuner on 2017/5/5.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRUserInfoData.h"

@implementation GRUserInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"userID": @"id",
             @"nickName": @"nickname",
            };
}

@end



@implementation GRUserInfoData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"userInfo": @"data"
            };
}

@end
