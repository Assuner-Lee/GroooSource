//
//  GRMenuCategoryCell.m
//  GroooSource
//
//  Created by Assuner on 2017/3/24.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRMenuCategoryCell.h"

@implementation GRMenuCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [GRAppStyle mainColorWithAlpha:0.1];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [GRAppStyle mainColorWithAlpha:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
