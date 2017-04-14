//
//  GRShopRatingList.m
//  GroooSource
//
//  Created by Assuner on 2017/3/30.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRShopRatingList.h"

@implementation GRShopRating

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"userLogo": @"logo",
             @"userNickName": @"nickname",
             @"userRating": @"rating",
             @"userRemark": @"rating_remark",
             };
}

@end


@implementation GRShopRatingList

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"dataArray": @"GRShopRating"};
}

@end
