//
//  GRShopListCell.m
//  GroooSource
//
//  Created by Assuner on 2017/2/22.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRShopListCell.h"
#import "GRAppStyle.h"
#import "UIImageView+AFNetworking.h"
#import "UIView+GRShortcut.h"

@interface GRShopListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *shopLogoImg;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *basePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthSoldLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopTypeLabel;

@property (weak, nonatomic) IBOutlet UIView *belowLine;

//*************** 动态控件 **************

@property (nonatomic, strong) UILabel *descTitleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *activityTitleLabel;
@property (nonatomic, strong) UILabel *activityLabel;
@property (nonatomic, strong) UIView *separateLine;

@end

@implementation GRShopListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [GRAppStyle mainColorWithAlpha:0.5];
    self.shopStatusLabel.layer.borderWidth = 1.0f;
    self.shopStatusLabel.layer.cornerRadius = 7.0f;
    
    self.monthSoldLabel.textColor = [GRAppStyle mainColor];
    
    self.shopTypeLabel.layer.cornerRadius = 6.0f;
    self.shopTypeLabel.clipsToBounds = YES;
    
    self.shopLogoImg.layer.cornerRadius = 2;
    self.shopLogoImg.clipsToBounds = YES;
    
    self.descTitleLabel = [UILabel new];
    self.descLabel = [UILabel new];
    _descLabel.numberOfLines = 0;
    self.activityTitleLabel = [UILabel new];
    self.activityLabel = [UILabel new];
    _activityLabel.numberOfLines = 0;

    self.separateLine = [UIView new];
    self.separateLine.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.12];
    [self.contentView addSubview:self.separateLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma - dataSource

- (void)setShopData:(GRShop *)shopData {
    if (!shopData) {
        return;
    }
    _shopData = shopData;
    _shopNameLabel.text = shopData.shopName;
    _shopStatusLabel.text = shopData.shopStatus ? @"营业中" : @"休息中";
    _shopStatusLabel.textColor = shopData.shopStatus ? [GRAppStyle mainColor] : [UIColor lightGrayColor];
    _shopStatusLabel.layer.borderColor = (shopData.shopStatus ? [GRAppStyle mainColor] : [UIColor lightGrayColor]).CGColor;
    _basePriceLabel.text = [NSString stringWithFormat:@"%zd元起送", shopData.basePrice];
    _monthSoldLabel.text = [NSString stringWithFormat:@"月销量: %zd", shopData.monthSold];
    _shopTypeLabel.hidden = YES;
    if ([shopData.shopType isEqualToString:@"超市"]) {
        _shopTypeLabel.text = @"超市";
        _shopTypeLabel.backgroundColor = [GRAppStyle mainColor];
        _shopTypeLabel.hidden = NO;
    } else if ([shopData.shopType isEqualToString:@"咕噜直营"]) {
        _shopTypeLabel.text = @"直营";
        _shopTypeLabel.backgroundColor = [GRAppStyle goldColor];
        _shopTypeLabel.hidden = NO;
    }
    
    NSMutableString *ratingStars = [[NSMutableString alloc] initWithString:@"★★"];
    for (int i = 0; i < shopData.shopRating - 2; i++) {
        [ratingStars appendString:@"★"];
    }
    _shopRatingLabel.text = ratingStars;
    
    [_shopLogoImg setImageWithURL:[NSURL URLWithString:[shopData.shopLogo stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"shop_placeholder"]];
    
    [_activityTitleLabel removeFromSuperview];
    [_activityLabel removeFromSuperview];
    [_descTitleLabel removeFromSuperview];
    [_descLabel removeFromSuperview];
    _belowLine.hidden = NO;
    _separateLine.frame = CGRectMake(0, shopData.shopCellParams.shopCellHight - 0.5, SCREEN_WIDTH, 0.5);
    if (!shopData.activity.length && !shopData.shopDesc.length) {
        _belowLine.hidden = YES;
    } else if (shopData.activity.length && shopData.shopDesc.length) {
        [self configShopActivity];
        [self configShopDicWithOrignY:_activityLabel.gr_bottom + 4];
    } else {
        if (shopData.activity.length) {
            [self configShopActivity];
        }
        if (shopData.shopDesc.length) {
            [self configShopDicWithOrignY:_belowLine.gr_bottom + 8];
        }
    }
}

- (void)configShopActivity {
    NSAttributedString *activityTitle = [[NSAttributedString alloc] initWithString:@"活动" attributes:[GRAppStyle attributeWithFont:[GRAppStyle font9] color:[UIColor whiteColor]]];
    _activityTitleLabel.frame = CGRectMake(_shopNameLabel.gr_left, _belowLine.gr_bottom + 8, activityTitle.size.width + 4, activityTitle.size.height);
    _activityTitleLabel.attributedText = activityTitle;
    _activityTitleLabel.textAlignment = NSTextAlignmentCenter;
    _activityTitleLabel.backgroundColor = [GRAppStyle activityRedColor];
    _activityTitleLabel.layer.cornerRadius = 2.0;
    _activityTitleLabel.clipsToBounds = YES;
    
    _activityLabel.frame = CGRectMake(_activityTitleLabel.gr_right + 5, _activityTitleLabel.gr_top, _shopData.shopCellParams.activityLabelSize.width, _shopData.shopCellParams.activityLabelSize.height);
    _activityLabel.text = _shopData.activity;
    _activityLabel.textColor = [UIColor grayColor];
    _activityLabel.font = [GRAppStyle font9];
    
    [self.contentView addSubview:_activityTitleLabel];
    [self.contentView addSubview:_activityLabel];
    _belowLine.hidden = NO;
}

- (void)configShopDicWithOrignY:(CGFloat)orignY {
    NSAttributedString *shopDescTitle = [[NSAttributedString alloc] initWithString:@"店铺" attributes:[GRAppStyle attributeWithFont:[GRAppStyle font9] color:[UIColor whiteColor]]];
    _descTitleLabel.frame = CGRectMake(_shopNameLabel.gr_left, orignY, shopDescTitle.size.width + 4, shopDescTitle.size.height);
    _descTitleLabel.attributedText = shopDescTitle;
    _descTitleLabel.textAlignment = NSTextAlignmentCenter;
    _descTitleLabel.backgroundColor = [GRAppStyle newGreenColor];
    _descTitleLabel.layer.cornerRadius = 2.0;
    _descTitleLabel.clipsToBounds = YES;
    
    _descLabel.frame = CGRectMake(_descTitleLabel.gr_right + 5, _descTitleLabel.gr_top, _shopData.shopCellParams.descLabelSize.width,_shopData.shopCellParams.descLabelSize.height);
    _descLabel.text = _shopData.shopDesc;
    _descLabel.textColor = [UIColor grayColor];
    _descLabel.font = [GRAppStyle font9];
    
    [self.contentView addSubview:_descTitleLabel];
    [self.contentView addSubview:_descLabel];
    _belowLine.hidden = NO;
}

@end
