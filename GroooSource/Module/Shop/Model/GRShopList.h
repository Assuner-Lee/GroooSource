//
//  GRShopList.h
//  GroooSource
//
//  Created by 李永光 on 2017/2/8.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRListTypeModel.h"

@interface GRShopCellParams : NSObject

@property (nonatomic, assign) CGSize activityLabelSize;
@property (nonatomic, assign) CGSize descLabelSize;
@property (nonatomic, assign) CGFloat shopCellHight;

@end


@interface GRShop : GRModel

//************** 模型属性 **************************

@property (nonatomic, strong) NSString *activity;       //活动
@property (nonatomic, strong) NSString *shopType;       //店铺类型
@property (nonatomic, strong) NSString *shopDesc;       //描述
@property (nonatomic, assign) NSUInteger shopID;        //id
@property (nonatomic, strong) NSString *shopLogo;       //logo地址
@property (nonatomic, assign) NSUInteger monthSold;     //月销量
@property (nonatomic, assign) NSUInteger basePrice;     //起送价
@property (nonatomic, strong) NSString *shopName;       //商家名字
@property (nonatomic, strong) NSString *shopPhone;      //商家电话
@property (nonatomic, assign) NSUInteger rateNumber;    //评价次数
@property (nonatomic, assign) CGFloat shopRating;       //商家评分
@property (nonatomic, assign) NSUInteger shopStatus;    //店铺状态

//************** 其他配置 **************************

@property (nonatomic, strong) GRShopCellParams *shopCellParams;  //cell动态高度

@end


@interface GRShopList : GRListTypeModel

@end
