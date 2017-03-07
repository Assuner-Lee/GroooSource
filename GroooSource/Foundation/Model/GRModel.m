//
//  GRModel.m
//  GroooSource
//
//  Created by 李永光 on 2017/2/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRModel.h"
#import "MJExtension.h"

@implementation GRModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return nil;
}

+ (NSDictionary *)mj_objectClassInArray {
    return nil;
}

+ (instancetype)jsonToModel:(NSDictionary *)json {
    return [self mj_objectWithKeyValues:json];
}

@end
