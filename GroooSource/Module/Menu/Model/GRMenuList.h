//
//  GRMenuList.h
//  GroooSource
//
//  Created by Assuner on 2017/3/23.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRListTypeModel.h"

@interface GRMenu : GRModel

@property (nonatomic, strong) NSString *menuCategory;
@property (nonatomic, strong) NSString *menuDesc;
@property (nonatomic, strong) NSString *menuID;
@property (nonatomic, strong) NSString *menuLogo;
@property (nonatomic, assign) NSUInteger menuMonthSold;
@property (nonatomic, strong) NSString *menuName;
@property (nonatomic, assign) NSUInteger menuPrice;
@property (nonatomic, assign) NSUInteger menuRemain;

@end


@interface GRMenuList : GRListTypeModel

@end
