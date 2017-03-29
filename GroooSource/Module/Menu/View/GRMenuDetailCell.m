//
//  GRMenuDetailCell.m
//  GroooSource
//
//  Created by Assuner on 2017/3/29.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRMenuDetailCell.h"
#import "UIImageView+AFNetworking.h"

@interface GRMenuDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *menuLogoImgView;
@property (weak, nonatomic) IBOutlet UILabel *menuNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *menuMonthSoldLabel;
@property (weak, nonatomic) IBOutlet UILabel *menuPriceLabel;

@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
@property (weak, nonatomic) IBOutlet UILabel *selectedCountLabel;

@property (nonatomic, strong) GRMenu *menu;
@property (nonatomic, assign) NSUInteger shopStatus;
@property (nonatomic, assign) NSInteger variation;

@end


@implementation GRMenuDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _menuLogoImgView.layer.cornerRadius = self.gr_width / 2;
    _menuLogoImgView.clipsToBounds = YES;
    
    _plusBtn.tag = 0;
    _minusBtn.tag = 1;
    [_plusBtn addTarget:self action:@selector(doSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_minusBtn addTarget:self action:@selector(doSelect:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setMenu:(GRMenu *)menu shopStatus:(NSUInteger)shopStatus {
    _menu = menu;
    _shopStatus = shopStatus;
    [_menuLogoImgView setImageWithURL:[NSURL URLWithString:[menu.menuLogo stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"menu_place_holder"]];
    _menuNameLabel.text = menu.menuName;
    _menuMonthSoldLabel.text = [NSString stringWithFormat:@"月销量: %zd", menu.menuMonthSold];
    if (menu.menuRemain && shopStatus) {
        _plusBtn.hidden = NO;
        [self selectedCountChanged];
    } else {
        _plusBtn.hidden = YES;
        _minusBtn.hidden = YES;
        _selectedCountLabel.hidden = YES;
    }
    
    if (menu.menuRemain) {
        _menuPriceLabel.backgroundColor = [UIColor whiteColor];
        _menuPriceLabel.textColor = [GRAppStyle mainColor];
        _menuPriceLabel.text = [NSString stringWithFormat:@"￥%zd", menu.menuPrice];
    } else {
        _menuPriceLabel.backgroundColor = [UIColor redColor];
        _menuPriceLabel.textColor = [UIColor whiteColor];
        _menuPriceLabel.text = @"已售罄";
    }
}

- (void)selectedCountChanged {
    if (_menu.selectCount) {
        _minusBtn.hidden = NO;
        _selectedCountLabel.hidden = NO;
        _selectedCountLabel.text = [NSString stringWithFormat:@"%zd", _menu.selectCount];
    } else {
        _minusBtn.hidden = YES;
        _selectedCountLabel.hidden = YES;
    }

}

#pragma - Actions {

- (void)doSelect:(UIButton *)sender {
    if (sender.tag == 0) {
        ++ _menu.selectCount;
        _variation = _menu.menuPrice;
    } else if (sender.tag == 1 && _menu.selectCount > 0) {
        -- _menu.selectCount;
         _variation = - _menu.menuPrice;
    }
    [self selectedCountChanged];
    if (self.selectBlock) {
        self.selectBlock(_variation);
    }
}

@end
