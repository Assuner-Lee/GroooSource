//
//  GRCashierdeskView.m
//  GroooSource
//
//  Created by Assuner on 2017/4/1.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRCashierdeskView.h"

typedef NS_ENUM(NSInteger, GROperateState) {
    GROperateStateZero = 0,
    GROperateStateLessThanBase = 1,
    GROperateStateReachBase = 2,
};

@interface GRCashierdeskView ()

@property (nonatomic, assign) NSUInteger shopID;
@property (nonatomic, assign) NSUInteger basePrice;
@property (nonatomic, strong) NSMutableDictionary *loggerDic;
@property (nonatomic, assign) NSUInteger totolPrice;
@property (nonatomic, assign) GROperateState operateState;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *operateLabel;

@property (nonatomic, strong) UIView *backsideView;
@property (nonatomic, assign, getter=isOpen) BOOL open;

@end


@implementation GRCashierdeskView

- (instancetype)initWithShopID:(NSUInteger)shopID basePrice:(NSUInteger)basePrice {
    if (self = [super init]) {
        _shopID = shopID;
        _basePrice = basePrice;
        self.frame = CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44);
        self.backgroundColor = [GRAppStyle mainColorWithAlpha:0.7];
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.frame = self.bounds;
        [self addSubview:effectview];
        self.loggerDic = [[NSMutableDictionary alloc] init];
        [self initView];
        self.totolPrice = [self getTotolPrice];
    }
    return self;
}

- (void)changeWithMenu:(GRMenu *)menu valueChange:(NSInteger)valueChange {
    NSString *key = [NSString stringWithFormat:@"%zd", menu.menuID];
    if ([_loggerDic.allKeys containsObject:key]) {
        if (!menu.selectCount) {
            [_loggerDic removeObjectForKey:key];
        }
    } else {
        [_loggerDic setObject:menu forKey:key];
    }
    self.totolPrice = [self getTotolPrice];
    if (valueChange > 0) {
        [UIView gr_showOscillatoryAnimationWithLayer:_icon.layer type:GROscillatoryAnimationToBigger range:1.5];
    } else {
        [UIView gr_showOscillatoryAnimationWithLayer:_icon.layer type:GROscillatoryAnimationToSmaller range:0.5];
    }
}


#pragma - Private Methods

- (void)initView {
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 45, 35)];
    _icon.userInteractionEnabled = YES;
    UITapGestureRecognizer *iconTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconPressed)];
    [_icon addGestureRecognizer:iconTap];
    [self addSubview:_icon];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 120, 44)];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.font = [UIFont boldSystemFontOfSize:17.0];
    _priceLabel.textColor = [UIColor whiteColor];
    [self addSubview:_priceLabel];
    
    _operateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - ADAPTX_VALUE(88), 0, ADAPTX_VALUE(88), 44)];
    _operateLabel.textAlignment = NSTextAlignmentCenter;
    _operateLabel.font = [UIFont systemFontOfSize:15.0];
    _operateLabel.textColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *operateTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(operate)];
    [_operateLabel addGestureRecognizer:operateTap];
    [self addSubview:_operateLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = [GRAppStyle lineColor];
    [self addSubview:line];
}

- (NSUInteger)getTotolPrice {
    NSArray<NSString *> *array = self.loggerDic.allKeys;
    NSUInteger totolPrice = 0;
    for (NSString *menuID in array) {
        GRMenu *menu = self.loggerDic[menuID];
        totolPrice += menu.menuPrice*menu.selectCount;
    }
    return totolPrice;
}

#pragma - Override

- (GROperateState)operateState {
    if (!_totolPrice) {
        return GROperateStateZero;
    } else if (_totolPrice < _basePrice) {
        return GROperateStateLessThanBase;
    } else {
        return GROperateStateReachBase;
    }
}

- (UIView *)backsideView {
    if (!_backsideView) {
        _backsideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44)];
        _backsideView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _backsideView.alpha = 0.0;
        UITapGestureRecognizer *backsideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconPressed)];
        [_backsideView addGestureRecognizer:backsideTap];
        return _backsideView;
    }
    return _backsideView;
}

- (void)setTotolPrice:(NSUInteger)number {
    _totolPrice = number;
    switch (self.operateState) {
        case GROperateStateZero: {
            _icon.image = [UIImage imageNamed:@"shopingcart_gray"];
            
            _priceLabel.hidden = YES;
            
            _operateLabel.backgroundColor = [UIColor lightGrayColor];
            _operateLabel.textColor = [UIColor whiteColor];
            _operateLabel.text = @"还没选哦";
            break;
        }
        case GROperateStateLessThanBase: {
            _icon.image = [UIImage imageNamed:@"shopingcart_white"];
            
            _priceLabel.hidden = NO;
            _priceLabel.text = [NSString stringWithFormat:@"共%zd元", _totolPrice];
            
            _operateLabel.backgroundColor = [UIColor whiteColor];
            _operateLabel.textColor = [UIColor blackColor];
            _operateLabel.text = [NSString stringWithFormat:@"还差%zd元", _basePrice - _totolPrice];
            break;
        }
        case GROperateStateReachBase: {
            _icon.image = [UIImage imageNamed:@"shopingcart_white"];
            
            _priceLabel.hidden = NO;
            _priceLabel.text = [NSString stringWithFormat:@"共%zd元", _totolPrice];
            
            _operateLabel.backgroundColor = [GRAppStyle orangeColor];
            _operateLabel.textColor = [UIColor whiteColor];
            _operateLabel.text = @"立即下单";
            break;
        }
    }
}

- (void)back {
    NSArray<NSString *> *array = self.loggerDic.allKeys;
    for (NSString *menuID in array) {
        GRMenu *menu = self.loggerDic[menuID];
        menu.selectCount = 0;
    }
}

#pragma - Actions

- (void)iconPressed {
    if (!self.isOpen) {
        [self.superview addSubview:self.backsideView];
        [UIView animateWithDuration:0.3 animations:^{
            _backsideView.alpha = 1.0;
        }];
    } else {
        [_backsideView removeFromSuperview];
        [UIView animateWithDuration:0.3 animations:^{
            _backsideView.alpha = 0.0;
        }];
    }
    self.open = !self.isOpen;
}

- (void)operate {
    
}

@end
