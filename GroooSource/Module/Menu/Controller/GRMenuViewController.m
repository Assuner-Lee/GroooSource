//
//  GRMenuViewController.m
//  GroooSource
//
//  Created by Assuner on 2017/3/23.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRMenuViewController.h"
#import "GRMenuHeadView.h"
#import "GRSegmentView.h"
#import "GRMenuMainView.h"
#import "GRShopRatingTable.h"
#import "GRMenuListRequest.h"
#import "GRCashierdeskView.h"

@interface GRMenuViewController () <UIScrollViewDelegate>

{
    CGFloat _originalHeadViewHeight;
}

@property (nonatomic, strong) GRShop *shop;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) GRMenuHeadView *headView;
@property (nonatomic, strong) GRSegmentView *segmentView;
@property (nonatomic, strong) GRMenuMainView *mainView;
@property (nonatomic, strong) GRShopRatingTable *ratingTable;
@property (nonatomic, strong) GRCashierdeskView *cashierdeskView;

@end


@implementation GRMenuViewController 

- (instancetype)initWithShop:(GRShop *)shop {
    if (self = [super init]) {
        _shop = shop;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initView];
    [self startRequest];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)back {
    [_cashierdeskView clear];
    [super back];
}

- (void)initView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:SCREEN_BOUNDS];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 2);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView] ;
    
    self.headView = [[GRMenuHeadView alloc] initWithShop:self.shop];
    _originalHeadViewHeight = _headView.gr_height;
    GRWEAK(self);
    self.headView.backBlock = ^{
        GRSTRONG(self);
        [self back];
    };
    [self.scrollView addSubview:self.headView];
    
    self.mainView = [[GRMenuMainView alloc] initWithShopStatus:self.shop.shopStatus];
    self.mainView.selectBlock = ^(GRMenu *menu, NSInteger valueChange) {
        GRSTRONG(self);
        [self.cashierdeskView changeWithMenu:menu valueChange:valueChange];
    };
    self.ratingTable = [[GRShopRatingTable alloc] initWithShopID:self.shop.shopID];
    
    self.segmentView = [[GRSegmentView alloc] initWithSubviewArray:@[_mainView, _ratingTable] titleArray:@[@"菜单", @"用户评价"] orignY:_headView.gr_height mainColor:[GRAppStyle mainColor]];
    [self.scrollView addSubview:self.segmentView];
    
    self.cashierdeskView = [[GRCashierdeskView alloc] initWithShop:_shop];
    self.cashierdeskView.reloadBlock = ^{
        GRSTRONG(self);
        [self.mainView reload];
    };
    [self.view addSubview:self.cashierdeskView];
}

- (void)startRequest {
    GRMenuListRequest *request = [[GRMenuListRequest alloc] initWithShopID:self.shop.shopID];
    if (request.cache) {
        self.mainView.menuDataArray = [request.cache dataArray];
    } else {
        [self showProgress];
    }
    
    GRWEAK(self);
    [request startRequestComplete:^(GRMenuList *  _Nullable responseObject, NSError * _Nullable error) {
        GRSTRONG(self);
        [self hideProgress];
        if (error) {
            [self showTimeOut];
            return;
        }
        if (responseObject.dataArray.count) {
            [self showProgress];
            self.mainView.menuDataArray = responseObject.dataArray;
            [self hideProgress];
        } else {
            [MBProgressHUD gr_showFailure:[NSString stringWithFormat:@"%@:暂无菜单", _shop.shopName]];
            [self back];
        }
    }];
}

#pragma - UIScrollView 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > _originalHeadViewHeight - 64) {
        offsetY = _originalHeadViewHeight - 64;
        self.scrollView.contentOffset = CGPointMake(0, offsetY);
    }
    _headView.gr_top = offsetY;
    _headView.gr_height = _originalHeadViewHeight - offsetY;
    [_headView changeWithOffsetY:offsetY];
    
}
@end
