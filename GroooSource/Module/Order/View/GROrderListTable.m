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
    self.contentInset = UIEdgeInsetsMake(44 - 5, 0, 49 + 5, 0);
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"GROrderListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:GROrderListCellID];
    [self initBlankView];
}

- (void)initBlankView {
    self.blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.gr_width, self.gr_height)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.gr_width - 0.9*ADAPTX_VALUE(320), self.gr_height - 0.9*ADAPTX_VALUE(500) - 49 - 44, 0.9*ADAPTY_VALUE(320), 0.9*ADAPTX_VALUE(500))];
    imgView.image = [UIImage imageNamed:@"grooo_blank"];
    [self.blankView addSubview:imgView];
    [self addSubview:_blankView];
}

- (void)setCellDataArray:(NSArray<GROrder *> *)cellDataArray {
    [_blankView removeFromSuperview];
    _cellDataArray = cellDataArray;
    [self reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    if (!cellDataArray.count) {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GROrderListCell *cell  = [tableView dequeueReusableCellWithIdentifier:GROrderListCellID forIndexPath:indexPath];
    cell.orderData = self.cellDataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellDataArray[indexPath.row].orderCellHight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _cellDataArray[indexPath.row].isSpread = !_cellDataArray[indexPath.row].isSpread;
    [self beginUpdates];
    GROrderListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self endUpdates];
    cell.isSpread = _cellDataArray[indexPath.row].isSpread;
}

@end
