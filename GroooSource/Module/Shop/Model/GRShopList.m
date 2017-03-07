//
//  GRShopList.m
//  GroooSource
//
//  Created by 李永光 on 2017/2/8.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRShopList.h"

@implementation GRShopCellParams

@end


@implementation GRShop

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"shopType": @"category",
             @"shopDesc": @"description",
             @"shopID": @"id",
             @"shopLogo": @"logo",
             @"shopName": @"name",
             @"shopPhone": @"phone",
             @"shopRating": @"rating",
             @"shopStatus": @"status"
            };
}

#pragma - getter 

- (GRShopCellParams *)shopCellParams {
    if (!_shopCellParams) {
        _shopCellParams = [[GRShopCellParams alloc] init];
        CGFloat maxLabelWidth = SCREEN_WIDTH - 76 - 5 - 24 - 6;
        CGSize activityTextSize = SIZE_OF_TEXT(_activity, CGSizeZero, 9.0).size;
        CGSize descTextSize = SIZE_OF_TEXT(_shopDesc, CGSizeZero, 9.0).size;
        _shopCellParams.activityLabelSize = CGSizeMake(maxLabelWidth, ceil(activityTextSize.width / maxLabelWidth) * activityTextSize.height);
        _shopCellParams.descLabelSize = CGSizeMake(maxLabelWidth, ceil(descTextSize.width / maxLabelWidth) * descTextSize.height);
        
        _shopCellParams.shopCellHight = 76 + (_shopCellParams.activityLabelSize.height ? _shopCellParams.activityLabelSize.height + 16 : 0) + (_shopCellParams.descLabelSize.height ? _shopCellParams.descLabelSize.height + 16 : 0) - ((_shopCellParams.activityLabelSize.height && _shopCellParams.descLabelSize.height) ? 11 : 0);
        
        return _shopCellParams;
    } else {
        return _shopCellParams;
    }
}

@end


@implementation GRShopList

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"dataArray": @"GRShop"};
}

@end
