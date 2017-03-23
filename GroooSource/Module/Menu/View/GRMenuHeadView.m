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



@property (nonatomic, strong) UIImageView *shopLogoView;

@property (nonatomic, strong) UILabel *shopNameLabel;

@property (nonatomic, strong) UILabel *shopPhoneLabel;

@end


@implementation GRMenuHeadView

- (instancetype)initWithShop:(GRShop *)shop {
    if (self = [super init]) {
        _shop = shop;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 128);
        [self initBacksideImageView];
    }
    return self;
}

- (void)setImage:(UIImageView *)imageview {
    [imageview setImageWithURL:[NSURL URLWithString:[_shop.shopLogo stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"shop_placeholder"]];
}

- (void)initBacksideImageView {
    
}

@end
