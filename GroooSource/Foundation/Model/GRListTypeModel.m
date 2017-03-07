//
//  GRListTypeModel.m
//  GroooSource
//
//  Created by 李永光 on 2017/2/8.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRListTypeModel.h"

@implementation GRListTypeModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"dataArray": @"data"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return nil;
}

@end
