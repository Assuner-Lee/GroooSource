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
    self.selectedBackgroundView.backgroundColor = [GRAppStyle mainColorWithAlpha:0.25];
    UIView *selectedLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, self.gr_height)];
    selectedLine.backgroundColor = [GRAppStyle mainColor];
    [self.selectedBackgroundView addSubview:selectedLine];
    selectedLine.layer.cornerRadius = 2;
    selectedLine.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
