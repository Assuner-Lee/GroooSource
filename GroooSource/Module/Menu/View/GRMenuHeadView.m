//
//  GRMenuHeadView.m
//  GroooSource
//
//  Created by Assuner on 2017/3/23.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRMenuHeadView.h"
#import "UIImageView+AFNetworking.h"

@interface GRMenuHeadView ()

@property (nonatomic, strong) GRShop *shop;

@property (nonatomic, strong) UIImageView *backsideImageView;

@property (nonatomic, strong) UIVisualEffectView *effectBacksideView;

@property (nonatomic, strong) UIImageView *shopLogoView;

@property (nonatomic, strong) UILabel *shopNameLabel;

@property (nonatomic, strong) UILabel *shopMonthSoldLabel;

@end


@implementation GRMenuHeadView

- (instancetype)initWithShop:(GRShop *)shop {
    if (self = [super init]) {
        _shop = shop;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 155);
        [self initView];
    }
    return self;
}

- (void)setImage:(UIImageView *)imageview {
    [imageview setImageWithURL:[NSURL URLWithString:[_shop.shopLogo stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"shop_placeholder"]];
}

- (void)initView {
    _backsideImageView = [[UIImageView alloc] init];
    _backsideImageView.contentMode = UIViewContentModeScaleToFill;
    [self setImage:_backsideImageView];
    [self addSubview:_backsideImageView];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _effectBacksideView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [_backsideImageView addSubview:_effectBacksideView];

    
    _shopLogoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 26, 70, 70)];
    _shopLogoView.gr_centerX = self.gr_centerX;
    [self setImage:_shopLogoView];
    _shopLogoView.backgroundColor = [UIColor blueColor];
    _shopLogoView.layer.cornerRadius = _shopLogoView.gr_width / 2;
    _shopLogoView.layer.borderWidth = 2.5f;
    _shopLogoView.layer.borderColor = [GRAppStyle mainColor].CGColor;
    _shopLogoView.clipsToBounds = YES;
    [self addSubview:_shopLogoView];
    
    _shopMonthSoldLabel = [UILabel new];
    _shopMonthSoldLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"月销量: %zd", _shop.monthSold] attributes:[GRAppStyle attributeWithFont:[UIFont systemFontOfSize:13.0] color:[UIColor whiteColor]]];
    _shopMonthSoldLabel.frame = CGRectMake(0, 0, MIN_SIZE(_shopMonthSoldLabel).width, MIN_SIZE(_shopMonthSoldLabel).height);
    _shopMonthSoldLabel.gr_centerX = self.gr_centerX;
    [self addSubview:_shopMonthSoldLabel];
    
    _shopNameLabel = [UILabel new];
    _shopNameLabel.attributedText = [[NSAttributedString alloc] initWithString:_shop.shopName attributes:[GRAppStyle attributeWithFont:[UIFont systemFontOfSize:14.0] color:[UIColor whiteColor]]];
    _shopNameLabel.frame = CGRectMake(0, 0, MIN_SIZE(_shopNameLabel).width, MIN_SIZE(_shopNameLabel).height);
    _shopNameLabel.gr_centerX = self.gr_centerX;
    [self addSubview:_shopNameLabel];
    [self setDynamicLabel];
    [self setDynamicImage];
}

- (void)changeWithOffsetY:(CGFloat)y {
    [self setDynamicImage];
    if (y < 0) {
        [self setDynamicLabel];
    } else {
        CGFloat alpha = 1.0 - y / self.gr_height;
        _shopLogoView.alpha = alpha;
        _shopNameLabel.alpha = alpha;
        _shopMonthSoldLabel.alpha = alpha;
    }
}

- (void)setDynamicImage {
    _backsideImageView.frame = self.bounds;
    _effectBacksideView.frame = _backsideImageView.bounds;
}

- (void)setDynamicLabel {
    _shopMonthSoldLabel.gr_bottom = self.gr_height - 6;
    _shopNameLabel.gr_bottom = _shopMonthSoldLabel.gr_top - 9;
}

- (void)setDynamicAlpha {
    
}

@end
