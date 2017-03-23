//
//  GRMenuList.h
//  GroooSource
//
//  Created by Assuner on 2017/3/23.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRListTypeModel.h"

@interface GRMenu : GRModel

@property (nonatomic, strong) NSString *menuCategory;        //类型
@property (nonatomic, strong) NSString *menuDesc;            //描述
@property (nonatomic, strong) NSString *menuID;              //ID
@property (nonatomic, strong) NSString *menuLogo;            //图片
@property (nonatomic, assign) NSUInteger menuMonthSold;      //月销量
@property (nonatomic, strong) NSString *menuName;            //名字
@property (nonatomic, assign) NSUInteger menuPrice;          //价格
@property (nonatomic, assign) NSUInteger menuRemain;         //库存

@end


@interface GRMenuList : GRListTypeModel

@end
