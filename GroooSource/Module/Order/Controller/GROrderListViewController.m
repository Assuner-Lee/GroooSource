//
//  GROrderListViewController.m
//  GroooSource
//
//  Created by Assuner on 2017/3/6.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GROrderListViewController.h"
#import "GROrderList.h"
#import "GROrderListCell.h"
#import "GROrderListRequest.h"
#import "GRSegmentView.h"
#import "GROrderListTable.h"
#import "GROrderStatusEnum.h"

@interface GROrderListViewController ()

@property (nonatomic, strong) NSArray<GROrder *> *dataArray;
@property (nonatomic, strong) NSMutableArray<GROrder *> *onGoingOrderArray;
@property (nonatomic, strong) NSMutableArray<GROrder *> *finishedOrderArray;
@property (nonatomic, strong) NSMutableArray<GROrder *> *otherOrderArray;

@property (nonatomic, strong) GROrderListRequest *orderListRequest;

@property (nonatomic, strong) GRSegmentView *segmentView;
@property (nonatomic, strong) GROrderListTable *onGoingOrderTable;
@property (nonatomic, strong) GROrderListTable *finishOrderTable;
@property (nonatomic, strong) GROrderListTable *otherOrderTable;

@property (nonatomic, assign, getter=shouldUpdateNextAppeared) BOOL updateNextAppeared;

@end

@implementation GROrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initRequest];
    [self startRequest];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.shouldUpdateNextAppeared) {
        [self startRequest];
        self.updateNextAppeared = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)init {
    if (self = [super init]) {
        self.onGoingOrderArray = [[NSMutableArray alloc] init];
        self.finishedOrderArray = [[NSMutableArray alloc] init];
        self.otherOrderArray = [[NSMutableArray alloc] init];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"我的订单";
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"订单" image:[UIImage imageNamed:@"bar_item_orderlist"] tag:0];
    return self;
}

- (void)setupBarItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(startRequest)];
}

- (void)addObservedNotification {
    [super addObservedNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUpadateState) name:GRUpdateOrderListNextAppearedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUpadateState) name:GRLoginSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUpadateState) name:GRLogoutSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearRequestCache) name:GRTokenInvaildNotification object:nil];
}

- (void)initView {
    self.onGoingOrderTable = [[GROrderListTable alloc] initWithType:GROrderTableTypeOnGoing];
    self.finishOrderTable = [[GROrderListTable alloc] initWithType:GROrderTableTypeFinished];
    self.otherOrderTable = [[GROrderListTable alloc] initWithType:GROrderTableTypeOther];
    self.segmentView = [[GRSegmentView alloc] initWithSubviewArray:@[_onGoingOrderTable, _finishOrderTable, _otherOrderTable] titleArray:@[_onGoingOrderTable.title, _finishOrderTable.title,  _otherOrderTable.title] orignY:64 mainColor:[GRAppStyle mainColor]];
    self.segmentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.segmentView];
}

- (void)initRequest {
    self.orderListRequest = [[GROrderListRequest alloc] init];
    if (self.orderListRequest.cache) {
        self.dataArray = [self.orderListRequest.cache dataArray];
    }
}

- (void)startRequest {
    [self showProgress];
    GRWEAK(self);
    [self.orderListRequest startRequestComplete:^(GROrderList *  _Nullable responseObject, NSError * _Nullable error) {
        GRSTRONG(self);
        [self hideProgress];
        if (error) {
            [self showTimeOut];
            self.dataArray = nil;
            return;
        }
        self.dataArray = responseObject.dataArray;
    }];
}

- (void)changeUpadateState {
    if (self.viewIfLoaded) {
        self.updateNextAppeared = YES;
    }
}

- (void)clearRequestCache {
    [self.orderListRequest clearCache];
}

#pragma - SetterOverride

- (void)setDataArray:(NSArray<GROrder *> *)dataArray {
        _dataArray = dataArray;
        [_onGoingOrderArray removeAllObjects];
        [_finishedOrderArray removeAllObjects];
        [_otherOrderArray removeAllObjects];
        for (GROrder *order in dataArray) {
            if (order.orderStatus == GROrderStatusNotTaked || order.orderStatus == GROrderStatusTaked) {
                [self.onGoingOrderArray addObject:order];
            } else if (order.orderStatus == GROrderStatusDone || order.orderStatus == GROrderStatusRated) {
                [self.finishedOrderArray addObject:order];
            } else {
                [self.otherOrderArray addObject:order];
            }
        }
        _onGoingOrderTable.cellDataArray = _onGoingOrderArray;
        _finishOrderTable.cellDataArray = _finishedOrderArray;
        _otherOrderTable.cellDataArray = _otherOrderArray;
}

@end
