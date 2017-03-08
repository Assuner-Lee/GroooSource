//
//  GROrderListTable.m
//  GroooSource
//
//  Created by Assuner on 2017/3/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GROrderListTable.h"
#import "GROrderListCell.h"

static NSString *GROrderListCellID = @"GROrderListCellID";

@interface GROrderListTable () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) GROrderTableType tableType;
@property (nonatomic, strong) UIView *blankView;

@end

@implementation GROrderListTable

- (instancetype)initWithType:(GROrderTableType)type {
    if (self = [super init]) {
        _tableType = type;
        [self initView];
    }
    return self;
}

- (void)initView {
    self.frame = CGRectMake(SCREEN_WIDTH * _tableType, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.dataSource = self;
    self.delegate = self;
    self.contentInset = UIEdgeInsetsMake(44, 0, 49, 0);
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"GROrderListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:GROrderListCellID];
    [self initBlankView];
}

- (void)initBlankView {
    self.blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.gr_width, self.gr_height)];
    self.blankView.backgroundColor = [UIColor whiteColor];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.44 * self.gr_width, self.gr_height -  0.66 * self.gr_width - 49 - 44, 0.56 * self.gr_width, 0.66 * self.gr_width)];
    imgView.image = [UIImage imageNamed:@"grooo_blank"];
    [self.blankView addSubview:imgView];
}

- (void)setCellDataArray:(NSArray<GROrder *> *)cellDataArray {
    [_blankView removeFromSuperview];
    if (cellDataArray.count) {
        _cellDataArray = cellDataArray;
        if (self.visibleCells.count) {
            [self reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, cellDataArray.count)] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            [self reloadData];
        }
    } else if (!self.visibleCells.count) {
        [self addSubview:self.blankView];
    }
}

- (NSString *)title {
    switch (_tableType) {
        case GROrderTableTypeOnGoing:
            return [NSString stringWithFormat:@"进行中"];
            
        case GROrderTableTypeFinished:
            return [NSString stringWithFormat:@"已完成"];
            
        case GROrderTableTypeOther:
            return [NSString stringWithFormat:@"其他单"];
    }
}

#pragma - TableView

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 10;
    }
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
    GROrderListCell *cell  = [self dequeueReusableCellWithIdentifier:GROrderListCellID forIndexPath:indexPath];
    cell.orderData = self.cellDataArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellDataArray[indexPath.section].orderCellHight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _cellDataArray[indexPath.section].isSpread = !_cellDataArray[indexPath.section].isSpread;
    [self beginUpdates];
    GROrderListCell *cell = [self cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    [self endUpdates];
    cell.isSpread = _cellDataArray[indexPath.section].isSpread;
}

@end
