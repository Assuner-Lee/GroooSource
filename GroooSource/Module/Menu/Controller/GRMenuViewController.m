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

@interface GRMenuViewController ()

@property (nonatomic, strong) GRShop *shop;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) GRMenuHeadView *headView;
@property (nonatomic, strong) GRSegmentView *segmentView;
@property (nonatomic, strong) GRMenuMainView *mainView;
@property (nonatomic, strong) GRShopRatingTable *ratingTable;

@end


@implementation GRMenuViewController

- (instancetype)initWithShop:(GRShop *)shop {
    if (self = [super init]) {
        _shop = shop;
        [self initView];
        [self startRequest];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:SCREEN_BOUNDS];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 2);
    [self.view addSubview:self.scrollView];
    
    self.headView = [[GRMenuHeadView alloc] initWithShop:self.shop];
    [self.scrollView addSubview:self.headView];
    
    self.mainView = [[GRMenuMainView alloc] initWithShopStatus:self.shop.shopStatus];
    self.ratingTable = [[GRShopRatingTable alloc] initWithShopID:self.shop.shopID];
    
    self.segmentView = [[GRSegmentView alloc] initWithSubviewArray:@[_mainView, _ratingTable] titleArray:@[@"菜单", @"评价"] orignY:_headView.gr_height mainColor:[GRAppStyle mainColor]];
    [self.scrollView addSubview:self.segmentView];
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
        self.mainView.menuDataArray = responseObject.dataArray;
    }];
}

@end
