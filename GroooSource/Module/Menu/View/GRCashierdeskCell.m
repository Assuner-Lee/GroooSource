//
//  GRCashierdeskCell.m
//  GroooSource
//
//  Created by Assuner on 2017/4/5.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRCashierdeskCell.h"

@interface  GRCashierdeskCell ()

@property (weak, nonatomic) IBOutlet UIView *dot;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
@property (weak, nonatomic) IBOutlet UILabel *selectedCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *menuNameLabel;

@end


@implementation GRCashierdeskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _dot.layer.cornerRadius = _dot.gr_width / 2;
    _dot.clipsToBounds = YES;
    _plusBtn.tag = 0;
    _minusBtn.tag = 1;
    [_plusBtn addTarget:self action:@selector(doSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_minusBtn addTarget:self action:@selector(doSelect:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setMenu:(GRMenu *)menu {
    _menu = menu;
    [self setView];
}

- (void)setView {
    _selectedCountLabel.text = @(_menu.selectCount).stringValue;
    _totalPriceLabel.text = [NSString stringWithFormat:@"￥%zd", _menu.selectCount * _menu.menuPrice];
    _menuNameLabel.text = _menu.menuName;
}

#pragma - Actions {

- (void)doSelect:(UIButton *)sender {
    if (sender.tag == 0) {
        ++ _menu.selectCount;
        if (self.selectBlock) {
            self.selectBlock(_menu, +1);
        }
        [UIView gr_showOscillatoryAnimationWithLayer:_selectedCountLabel.layer type:GROscillatoryAnimationToBigger range:1.5];
    } else if (sender.tag == 1 && _menu.selectCount > 0) {
        -- _menu.selectCount;
        if (!_menu.selectCount && self.toZeroBlock) {
            self.toZeroBlock();
        }
        if (self.selectBlock) {
            self.selectBlock(_menu, -1);
        }
        [UIView gr_showOscillatoryAnimationWithLayer:_selectedCountLabel.layer type:GROscillatoryAnimationToSmaller range:0.5];
    }
    if (_menu.selectCount) {
        [self setView];
    }
}

@end
