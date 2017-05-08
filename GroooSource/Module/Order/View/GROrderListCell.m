//
//  GROrderListCell.m
//  GroooSource
//
//  Created by Assuner on 2017/3/6.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GROrderListCell.h"
#import "GROrderStatusLabel.h"
#import "GROperateOrderBtn.h"

@interface GROrderListCell ()
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet GROrderStatusLabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shopLogo;
@property (weak, nonatomic) IBOutlet UILabel *orderSumLabel;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderIDLabel;
@property (weak, nonatomic) IBOutlet GROperateOrderBtn *operateStatusBtn;

@property (nonatomic, strong) UIView *selectedView;
@property (nonatomic, strong) UIButton *orderDetailView;

@end


@implementation GROrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    self.selectedView.backgroundColor = [GRAppStyle mainColorWithAlpha:0.5];
    UIView *fakeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    fakeView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.selectedView addSubview:fakeView];
    
    self.operateStatusBtn.layer.cornerRadius = 8;
    self.operateStatusBtn.clipsToBounds = YES;
    self.shopLogo.layer.cornerRadius = 2;
    self.shopLogo.clipsToBounds = YES;
    self.shopLogo.userInteractionEnabled = YES;
    [self.shopLogo gr_addTapAction:^{
        [GRRouter open:@"push->GRMenuViewController" params:@{@"shop": _orderData.shop}];
    }];
    self.clipsToBounds = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
    if (![self.selectedBackgroundView isEqual:self.selectedView]) {
        self.selectedBackgroundView = self.selectedView;
    }
}

- (void)setOrderData:(GROrder *)orderData {
    _orderData = orderData;
    _orderIDLabel.text = [NSString stringWithFormat:@"订单号: %@", orderData.orderID];
    _orderStatusLabel.orderStatus = orderData.orderStatus;
    _shopNameLabel.text = [NSString stringWithFormat:@"♨ %@", orderData.shop.shopName];
    _orderTimeLabel.text = orderData.placeOrderTime;
    _orderSumLabel.text = [NSString stringWithFormat:@"总额: ¥%zd", orderData.cost];
    _operateStatusBtn.orderStatus = orderData.orderStatus;
    
    [_shopLogo setImageWithURL:[NSURL URLWithString:[orderData.shop.shopLogo stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"shop_placeholder"]];
    [self configOrderDetailView:orderData];
}

- (void)setIsSpread:(BOOL)isSpread {
    _isSpread = isSpread;
    
    if (isSpread) {
        _moreLabel.text = @"△";
    } else {
        _moreLabel.text = @"▽";
    }
}

- (void)configOrderDetailView:(GROrder *)orderData {
    [_orderDetailView removeFromSuperview];
    _orderDetailView = [[UIButton alloc] initWithFrame:CGRectMake(0, 140, SCREEN_WIDTH, orderData.orderCellMaxHight - 140)];
    [self addSubview:_orderDetailView];
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(8, 0, _orderDetailView.gr_width - 8, 0.7)];
    topLine.backgroundColor = [GRAppStyle lineColor];
    [_orderDetailView addSubview:topLine];
    NSDictionary *foodStringattribute = [GRAppStyle attributeWithFont:[GRAppStyle font12] color:[UIColor darkGrayColor]];
    for (int i = 1; i <= orderData.orderDetail.count; i++) {
        NSAttributedString *foodString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", orderData.orderDetail[i - 1].foodName] attributes:foodStringattribute];
        UILabel *foodLabel = [[UILabel alloc] initWithFrame:CGRectMake(76, 8 + 30 * (i - 1), foodString.size.width, foodString.size.height)];
        foodLabel.attributedText = foodString;
        [_orderDetailView addSubview:foodLabel];
        
        UILabel *ballIcon = [[UILabel alloc] initWithFrame:CGRectMake(36, foodLabel.gr_top + 5, foodLabel.gr_height - 10, foodLabel.gr_height - 10)];
        ballIcon.backgroundColor = [GRAppStyle mainColor];
        ballIcon.layer.cornerRadius = 0.5 * ballIcon.gr_width;
        ballIcon.clipsToBounds = YES;
        [_orderDetailView addSubview:ballIcon];
        
        
        NSAttributedString *countString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"x %zd", orderData.orderDetail[i - 1].foodCount] attributes:foodStringattribute];
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(_orderDetailView.gr_width - 35, foodLabel.gr_top, countString.size.width, countString.size.height)];
        countLabel.attributedText = countString;
        [_orderDetailView addSubview:countLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(8, 30 * i, _orderDetailView.gr_width - 8, 0.7)];
        line.backgroundColor = [GRAppStyle lineColor];
        [_orderDetailView addSubview:line];
    }
}


@end
