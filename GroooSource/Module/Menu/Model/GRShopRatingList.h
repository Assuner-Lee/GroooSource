//
//  GRShopRatingList.h
//  GroooSource
//
//  Created by Assuner on 2017/3/30.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRListTypeModel.h"

@interface GRShopRating : GRModel

@property (nonatomic, strong) NSString *userLogo;
@property (nonatomic, strong) NSString *userNickName;
@property (nonatomic, assign) NSUInteger userRating;
@property (nonatomic, strong) NSString *userRemark;
@property (nonatomic, strong) NSString *time;

@end


@interface GRShopRatingList : GRListTypeModel

@end
