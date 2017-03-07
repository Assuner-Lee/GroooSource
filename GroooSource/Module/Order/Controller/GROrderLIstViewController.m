//
//  GROrderLIstViewController.m
//  GroooSource
//
//  Created by Assuner on 2017/3/6.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GROrderLIstViewController.h"
#import "GROrderList.h"
#import "GROrderListCell.h"
#import "GROrderListRequest.h"

static NSString *GROrderListCellID = @"GROrderListCellID";

@interface GROrderLIstViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) UITableView *orderListTableView;
@property (nonatomic, strong) NSArray<GROrder *> *cellDataArray;
@property (nonatomic, strong) GROrderListRequest *orderListRequest;

@end

@implementation GROrderLIstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initRequest];
    [self startRequest];
}

- (void)setupBarItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(startRequest)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView {
    self.orderListTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.orderListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.orderListTableView.delegate = self;
    self.orderListTableView.dataSource = self;
    self.orderListTableView.scrollsToTop = YES;
    self.orderListTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.orderListTableView];
    [self.orderListTableView registerNib:[UINib nibWithNibName:@"GROrderListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:GROrderListCellID];
}

- (void)initRequest {
    self.orderListRequest = [[GROrderListRequest alloc] init];
    if (self.orderListRequest.cache) {
        self.cellDataArray = [self.orderListRequest.cache dataArray];
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
        self.cellDataArray = responseObject.dataArray;
    }];
}

#pragma - SetterOverride 

- (void)setCellDataArray:(NSArray<GROrder *> *)cellDataArray {
    if (cellDataArray.count) {
        _cellDataArray = cellDataArray;
        if (_orderListTableView.visibleCells.count) {
            [_orderListTableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, _cellDataArray.count)] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            [_orderListTableView reloadData];
        }
        
    }
}

#pragma - TableView 

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GROrderListCell *cell  = [self.orderListTableView dequeueReusableCellWithIdentifier:GROrderListCellID forIndexPath:indexPath];
    cell.orderData = self.cellDataArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellDataArray[indexPath.section].orderCellHight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _cellDataArray[indexPath.section].isSpread = !_cellDataArray[indexPath.section].isSpread;
    [self.orderListTableView beginUpdates];
    GROrderListCell *cell = [self.orderListTableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    [self.orderListTableView endUpdates];
    cell.isSpread = _cellDataArray[indexPath.section].isSpread;
}

@end
