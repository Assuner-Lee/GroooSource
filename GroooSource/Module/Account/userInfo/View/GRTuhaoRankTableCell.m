//
//  GRTuhaoRankTableCell.m
//  GroooSource
//
//  Created by Assuner on 2017/5/8.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRTuhaoRankTableCell.h"
#import "GRUserInfoData.h"

@interface GRTuhaoRankTableCell ()

@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNicknameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *crownImgView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic, assign) BOOL isMoved;

@end


@implementation GRTuhaoRankTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userAvatarImgView.layer.cornerRadius = self.userAvatarImgView.gr_width / 2;
    self.userAvatarImgView.clipsToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setUserInfo:(GRUserInfo *)userInfo {
    _userInfo = userInfo;
    [self.userAvatarImgView setImageWithURL:[NSURL URLWithString:userInfo.avatar] placeholderImage:[UIImage imageNamed:@"user_avatar_placeholder"]];
    
    self.self.userNicknameLabel.text = userInfo.nickName;
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", userInfo.score];
}

- (void)setRankNumber:(NSUInteger)rankNumber {
    _rankNumber = rankNumber;
    self.rankLabel.text = @(rankNumber + 1).stringValue;
    if (rankNumber < 5) {
        if (rankNumber) {
            self.rankLabel.font = [UIFont boldSystemFontOfSize:17.0];
        } else {
            self.rankLabel.font = [UIFont boldSystemFontOfSize:25.0];
        }
        self.rankLabel.textColor = [GRAppStyle orangeColor];
        self.crownImgView.hidden = NO;
        if (!self.isMoved) {
            [self performSelector:@selector(move) withObject:nil afterDelay:0.5 + 0.3 * rankNumber];
        }
        [self.contentView gr_addTapAction:^{
            [self move];
        }];
    } else {
        self.rankLabel.font = [UIFont systemFontOfSize:12.0];
        self.rankLabel.textColor = [UIColor darkGrayColor];
        self.crownImgView.hidden = YES;
    }
    
}

- (void)move {
    [UIView gr_showOscillatoryAnimationWithLayer:self.crownImgView.layer type:GROscillatoryAnimationToBigger range:2.0];
    self.isMoved = YES;
}

@end
