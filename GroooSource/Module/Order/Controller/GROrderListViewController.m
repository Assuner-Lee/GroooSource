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

@end

@implementation GROrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initRequest];
    [self startRequest];
}

- (instancetype)init {
    if (self = [super init]) {
        self.onGoingOrderArray = [[NSMutableArray alloc] init];
        self.finishedOrderArray = [[NSMutableArray alloc] init];
        self.otherOrderArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setupBarItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(startRequest)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView {
    self.onGoingOrderTable = [[GROrderListTable alloc] initWithType:GROrderTableTypeOnGoing];
    self.finishOrderTable = [[GROrderListTable alloc] initWithType:GROrderTableTypeFinished];
    self.otherOrderTable = [[GROrderListTable alloc] initWithType:GROrderTableTypeOther];
    self.segmentView = [[GRSegmentView alloc] initWithSubviewArray:@[_onGoingOrderTable, _finishOrderTable, _otherOrderTable] titleArray:@[_onGoingOrderTable.title, _finishOrderTable.title,  _otherOrderTable.title] orignY:64];
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
    if (!self.orderListRequest.cache) {
        [self showProgress];
    }
    GRWEAK(self);
    [self.orderListRequest startRequestComplete:^(GROrderList *  _Nullable responseObject, NSError * _Nullable error) {
        GRSTRONG(self);
        [self hideProgress];
        if (error) {
            [self showTimeOut];
            return;
        }
        self.dataArray = responseObject.dataArray;
    }];
}

#pragma - SetterOverride

- (void)setDataArray:(NSArray<GROrder *> *)dataArray {
    if (dataArray.count) {
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
}

@end
