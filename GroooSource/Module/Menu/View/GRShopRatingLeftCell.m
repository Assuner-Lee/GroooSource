//
//  GRShopRatingLeftCell.m
//  GroooSource
//
//  Created by Assuner on 2017/3/30.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRShopRatingLeftCell.h"

@interface GRShopRatingLeftCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userLogoImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRemarkLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end


@implementation GRShopRatingLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userLogoImgView.layer.cornerRadius = 8;
    self.userLogoImgView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma - Override 

- (void)setShopRating:(GRShopRating *)shopRating {
    _shopRating = shopRating;
    _userNameLabel.text = shopRating.userNickName;
    _userRemarkLabel.text = shopRating.userRemark.length ? [NSString stringWithFormat:@"“%@”", shopRating.userRemark] : @"“暂无评价”";
    _timeLabel.text = shopRating.time;
    [_userLogoImgView setImageWithURL:[NSURL URLWithString:[shopRating.userLogo stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"user_placeholder"]];
}

@end
