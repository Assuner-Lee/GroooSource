//
//  GRCashierdeskView.m
//  GroooSource
//
//  Created by Assuner on 2017/4/1.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRCashierdeskView.h"

typedef NS_ENUM(NSInteger, GROperateState) {
    GROperateStateZero = -1,
    GROperateStateLessThanBase = 0,
    GROperateStateReachBase = 1,
};

@interface GRCashierdeskView ()

@property (nonatomic, assign) NSUInteger shopID;
@property (nonatomic, assign) NSUInteger basePrice;
@property (nonatomic, strong) NSMutableDictionary *loggerDic;
@property (nonatomic, strong) UIView *detailView;
@property (nonatomic, strong) UIView *backsideView;
@property (nonatomic, strong) UILabel *operateLabel;

@end


@implementation GRCashierdeskView

- (instancetype)initWithShopID:(NSUInteger)shopID basePrice:(NSUInteger)basePrice {
    if (self = [super init]) {
        _shopID = shopID;
        _basePrice = basePrice;
        self.frame = CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44);
        self.backgroundColor = [GRAppStyle mainColorWithAlpha:0.7];
        [self initView];
    }
    return self;
}

- (void)initView {
    _operateLabel = [[UILabel alloc] init];
    _operateLabel.backgroundColor =
}

@end
