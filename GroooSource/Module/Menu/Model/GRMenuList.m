//
//  GRMenuList.m
//  GroooSource
//
//  Created by Assuner on 2017/3/23.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRMenuList.h"

@implementation GRMenu

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"menuCategory": @"category",
             @"menuDesc": @"description",
             @"menuID": @"id",
             @"menuLogo": @"logo",
             @"menuMonthSold": @"monthSold",
             @"menuName": @"name",
             @"menuPrice": @"price",
             @"menuRemain": @"remain"
             };
}

@end


@implementation GRMenuList

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"dataArray": @"GRMenu"};
}

@end
