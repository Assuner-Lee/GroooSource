//
//  GROrderList.h
//  GroooSource
//
//  Created by Assuner on 2017/2/28.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRListTypeModel.h"
#import "GRShopList.h"
#import "GROrderStatusEnum.h"

@interface GRFood : GRModel

@property (nonatomic, assign) NSUInteger foodCount;
@property (nonatomic, strong) NSString *foodName;

@end

@interface GROrder : GRModel

@property (nonatomic, strong) NSString *userAddress;
@property (nonatomic, strong) NSString *building;
@property (nonatomic, strong) NSArray<GRFood *> *orderDetail;
@property (nonatomic, strong) NSString *orderID;
@property (nonatomic, assign) NSUInteger cost;
@property (nonatomic, assign) NSUInteger userRating;
@property (nonatomic, strong) NSString *userRemark;
@property (nonatomic, strong) GRShop *shop;
@property (nonatomic, assign) GROrderStatus orderStatus;
@property (nonatomic, strong) NSString *placeOrderTime;
@property (nonatomic, strong) NSString *userName;

//************ 动态布局 ************

@property (nonatomic, assign) CGFloat orderCellHight;
@property (nonatomic, assign) CGFloat orderCellMaxHight;
@property (nonatomic, assign) BOOL isSpread;

@end


@interface GROrderList : GRListTypeModel

@end
