//
//  GRCashierdeskView.m
//  GroooSource
//
//  Created by Assuner on 2017/4/1.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRCashierdeskView.h"
#import "GRPlaceOrderRequest.h"

typedef NS_ENUM(NSInteger, GROperateState) {
    GROperateStateZero = 0,
    GROperateStateLessThanBase = 1,
    GROperateStateReachBase = 2,
};

static NSString *GRCashierdeskCellID = @"GRCashierdeskCellID";

@interface GRCashierdeskView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) GRShop *shop;
@property (nonatomic, strong) NSMutableDictionary *loggerDic;
@property (nonatomic, assign) NSUInteger totolPrice;
@property (nonatomic, assign) GROperateState operateState;
@property (nonatomic, assign, getter=isOpen) BOOL open;
@property (nonatomic, strong) NSMutableArray *orderDetailArray;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *operateLabel;

@property (nonatomic, strong) UIView *backsideView;
@property (nonatomic, strong) UIView *tableBackView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UITableView *cashierdeskTable;
@property (nonatomic, strong) NSMutableArray<GRMenu *> *cellDataArray;

@end


@implementation GRCashierdeskView

- (instancetype)initWithShop:(GRShop *)shop {
    if (self = [super init]) {
        _shop = shop;
        self.frame = CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44);
        self.backgroundColor = [GRAppStyle mainColorWithAlpha:0.7];
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.frame = self.bounds;
        [self addSubview:effectview];
        self.loggerDic = [[NSMutableDictionary alloc] init];
        self.orderDetailArray = [[NSMutableArray alloc] init];
        [self initView];
        self.totolPrice = [self getTotolPrice];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearDic) name:GRMenuReloadedNotification object:nil];
    }
    return self;
}

- (void)changeWithMenu:(GRMenu *)menu valueChange:(NSInteger)valueChange {
    NSString *key = menu.menuID;
    if ([_loggerDic.allKeys containsObject:key]) {
        if (!menu.selectCount) {
            [_loggerDic removeObjectForKey:key];
        }
    } else {
        [_loggerDic setObject:menu forKey:key];
    }
    self.totolPrice = [self getTotolPrice];
    if (valueChange > 0) {
        [UIView gr_showOscillatoryAnimationWithLayer:_icon.layer type:GROscillatoryAnimationToBigger range:1.5];
    } else {
        [UIView gr_showOscillatoryAnimationWithLayer:_icon.layer type:GROscillatoryAnimationToSmaller range:0.5];
    }
}


#pragma - Private Methods

- (void)initView {
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 45, 35)];
    _icon.userInteractionEnabled = YES;
    UITapGestureRecognizer *iconTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconPressed)];
    [_icon addGestureRecognizer:iconTap];
    [self addSubview:_icon];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 120, 44)];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.font = [UIFont boldSystemFontOfSize:17.0];
    _priceLabel.textColor = [UIColor whiteColor];
    _priceLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *priceTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconPressed)];
    [_priceLabel addGestureRecognizer:priceTap];
    [self addSubview:_priceLabel];
    
    _operateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - ADAPTX_VALUE(88), 0, ADAPTX_VALUE(88), 44)];
    _operateLabel.textAlignment = NSTextAlignmentCenter;
    _operateLabel.font = [UIFont systemFontOfSize:15.0];
    _operateLabel.textColor = [UIColor whiteColor];
    _operateLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *operateTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(operate)];
    [_operateLabel addGestureRecognizer:operateTap];
    [self addSubview:_operateLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = [GRAppStyle lineColor];
    [self addSubview:line];
}

- (NSUInteger)getTotolPrice {
    NSArray<NSString *> *array = self.loggerDic.allKeys;
    NSUInteger totolPrice = 0;
    for (NSString *menuID in array) {
        GRMenu *menu = self.loggerDic[menuID];
        totolPrice += menu.menuPrice*menu.selectCount;
    }
    return totolPrice;
}

- (void)initMenus {
    NSArray<NSString *> *array = self.loggerDic.allKeys;
    for (NSString *menuID in array) {
        GRMenu *menu = self.loggerDic[menuID];
        menu.selectCount = 0;
    }
}

- (void)clear {
    [self initMenus];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma - Override

- (GROperateState)operateState {
    if (!_totolPrice) {
        return GROperateStateZero;
    } else if (_totolPrice < _shop.basePrice) {
        return GROperateStateLessThanBase;
    } else {
        return GROperateStateReachBase;
    }
}

- (UIView *)backsideView {
    if (!_backsideView) {
        _backsideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44)];
        _backsideView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _backsideView.alpha = 0.0;
        UITapGestureRecognizer *backsideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconPressed)];
        [_backsideView addGestureRecognizer:backsideTap];
        return _backsideView;
    }
    return _backsideView;
}

- (UIView *)tableBackView {
    if (!_tableBackView) {
        _tableBackView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, [self tableViewHight] + 30)];
        _tableBackView.backgroundColor = [UIColor whiteColor];
    }
    return _tableBackView;
}

- (UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _tableHeaderView.backgroundColor = [[GRAppStyle mainColor] colorWithAlphaComponent:0.9];;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 7.5, 3, 15)];
        line.backgroundColor = [UIColor whiteColor];
        line.layer.cornerRadius = 1;
        line.clipsToBounds = YES;
        [_tableHeaderView addSubview:line];
        
        UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 60, 30)];
        titleLabel.attributedText = [[NSAttributedString alloc] initWithString:@"购物车" attributes:[GRAppStyle attributeWithFont:[UIFont boldSystemFontOfSize:14.0] color:[UIColor whiteColor]]];
        [_tableHeaderView addSubview:titleLabel];
        
        UIImageView *clearIcon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 43, 3, 45, 24)];
        clearIcon.image = [UIImage imageNamed:@"bin_icon"];
        clearIcon.contentMode = UIViewContentModeScaleAspectFit;
        clearIcon.userInteractionEnabled = YES;
        [_tableHeaderView addSubview:clearIcon];
        UITapGestureRecognizer *clearIconTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClearIcon)];
        [clearIcon addGestureRecognizer:clearIconTap];
    }
    return _tableHeaderView;
}

- (UITableView *)cashierdeskTable {
    if (!_cashierdeskTable) {
        _cashierdeskTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, [self tableViewHight]) style:UITableViewStylePlain];
        _cashierdeskTable.dataSource = self;
        _cashierdeskTable.delegate = self;
        _cashierdeskTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _cashierdeskTable.showsVerticalScrollIndicator = NO;
        [_cashierdeskTable registerNib:[UINib nibWithNibName:@"GRCashierdeskCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:GRCashierdeskCellID];
        
        [self.superview addSubview:self.backsideView];
        [self.superview addSubview:self.tableBackView];
        [self.tableBackView addSubview:self.tableHeaderView];
        [self.tableBackView addSubview:_cashierdeskTable];
    }
    return _cashierdeskTable;
}

- (void)setCellDataArray:(NSMutableArray<GRMenu *> *)cellDataArray {
    if (cellDataArray.count) {
        _cellDataArray = cellDataArray;
        [self.cashierdeskTable reloadData];
    }
}

- (void)setTotolPrice:(NSUInteger)number {
    _totolPrice = number;
    switch (self.operateState) {
        case GROperateStateZero: {
            _icon.image = [UIImage imageNamed:@"shopingcart_gray"];
            
            _priceLabel.hidden = YES;
            
            _operateLabel.backgroundColor = [UIColor lightGrayColor];
            _operateLabel.textColor = [UIColor whiteColor];
            if (_shop.shopStatus) {
                 _operateLabel.text = @"还没选哦";
            } else {
                 _operateLabel.text = @"休息中";
            }
            break;
        }
        case GROperateStateLessThanBase: {
            _icon.image = [UIImage imageNamed:@"shopingcart_white"];
            
            _priceLabel.hidden = NO;
            _priceLabel.text = [NSString stringWithFormat:@"共%zd元", _totolPrice];
            
            _operateLabel.backgroundColor = [UIColor whiteColor];
            _operateLabel.textColor = [UIColor blackColor];
            _operateLabel.text = [NSString stringWithFormat:@"还差%zd元", _shop.basePrice - _totolPrice];
            break;
        }
        case GROperateStateReachBase: {
            _icon.image = [UIImage imageNamed:@"shopingcart_white"];
            
            _priceLabel.hidden = NO;
            _priceLabel.text = [NSString stringWithFormat:@"共%zd元", _totolPrice];
            
            _operateLabel.backgroundColor = [GRAppStyle orangeColor];
            _operateLabel.textColor = [UIColor whiteColor];
            _operateLabel.text = @"立即下单";
            break;
        }
    }
}

- (NSMutableArray *)orderDetailArray {
    [_orderDetailArray removeAllObjects];
    NSArray *valueArray = _loggerDic.allValues;
    if (valueArray.count) {
        for (GRMenu *menu in valueArray) {
            [_orderDetailArray addObject:@{@"id": menu.menuID, @"count": @(menu.selectCount)}];
        }
    }
    return _orderDetailArray;
}

#pragma - Actions

- (void)iconPressed {
    if (!self.isOpen) {
        if (_loggerDic.allKeys.count) {
            self.cellDataArray = [NSMutableArray arrayWithArray:_loggerDic.allValues];
            [self.superview bringSubviewToFront:self];
            _cashierdeskTable.gr_height = [self tableViewHight];
            [UIView animateWithDuration:0.5 animations:^{
                _backsideView.alpha = 1.0;
                _tableBackView.frame = CGRectMake(0, SCREEN_HEIGHT - 44 - [self tableViewHight] - 30, SCREEN_WIDTH, [self tableViewHight] + 30);
                
            }];
             self.open = !self.isOpen;
        }
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            _backsideView.alpha = 0.0;
            _tableBackView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, [self tableViewHight] + 30);
        }];
        self.open = !self.isOpen;
    }
   
}

- (void)operate {
    if (!self.orderDetailArray.count) {
        return;
    }
    [UIView gr_showOscillatoryAnimationWithLayer:_operateLabel.layer type:GROscillatoryAnimationToBigger range:1.5];
    _operateLabel.gestureRecognizers[0].enabled = NO;
    [MBProgressHUD gr_showProgress];
    [[[GRPlaceOrderRequest alloc] initWithShopID:_shop.shopID ordersParams:self.orderDetailArray] startRequestComplete:^(id  _Nullable responseObject, NSError * _Nullable error) {
        [MBProgressHUD gr_hideProgress];
        if (error) {
            _operateLabel.gestureRecognizers[0].enabled = YES;
            return;
        }
        _operateLabel.gestureRecognizers[0].enabled = YES;
        [MBProgressHUD gr_showSuccess:@"下单成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:GRUpdateOrderListNextAppearedNotification object:nil];
        [ROOT_VC setSelectedIndex:1];
    }];
}

- (void)clearDic {
    [_loggerDic removeAllObjects];
    self.totolPrice = [self getTotolPrice];
}

- (void)tapClearIcon {
    [self initMenus];
    [self clearDic];
    if (self.reloadBlock) {
        self.reloadBlock();
    }
    [self iconPressed];
}

#pragma - UITableView 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GRCashierdeskCell *cell = [tableView dequeueReusableCellWithIdentifier:GRCashierdeskCellID forIndexPath:indexPath];
    cell.menu = _cellDataArray[indexPath.row];
    GRWEAK(cell);
    cell.toZeroBlock = ^{
        GRSTRONG(cell);
        [self.cellDataArray removeObject:cell.menu];
        [tableView deleteRowsAtIndexPaths:@[[_cashierdeskTable indexPathForCell:cell]] withRowAnimation:(_cellDataArray.count > 5 ? UITableViewRowAnimationLeft : UITableViewRowAnimationFade)];
        [UIView animateWithDuration:0.3 animations:^{
             _tableBackView.frame = CGRectMake(0, SCREEN_HEIGHT - 44 - [self tableViewHight] - 30, SCREEN_WIDTH, [self tableViewHight] + 30);
        }];
        if (!_cellDataArray.count) {
            [self iconPressed];
        }
    };
    GRWEAK(self);
    cell.selectBlock = ^(GRMenu *menu, NSInteger valueChange) {
        GRSTRONG(self);
        [self changeWithMenu:menu valueChange:valueChange];
        if (self.reloadBlock) {
            self.reloadBlock();
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

- (CGFloat)tableViewHight {
    return 40.0 * (_cellDataArray.count > 5 ? 5 : _cellDataArray.count);
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *clearAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"清空" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
    GRCashierdeskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.menu.selectCount = 0;
    if (cell.selectBlock) {
        cell.selectBlock(cell.menu, -1);
    }
    if (cell.toZeroBlock) {
        cell.toZeroBlock();
    }
    }];
    return @[clearAction];
}

@end
