//
//  GRTuhaoRankController.m
//  GroooSource
//
//  Created by Assuner on 2017/5/8.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRTuhaoRankController.h"
#import "GRTuhaoRankTableCell.h"
#import "GRRankListRequest.h"
#import "GRTuhaoRankList.h"

static NSString *GRTuhaoRankTableCellID = @"GRTuhaoRankTableCellID";

@interface GRTuhaoRankController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray<GRUserInfo *> *cellDataArray;

@end

@implementation GRTuhaoRankController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"咕噜土豪榜";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.layer.cornerRadius = 4.0;
    self.tableView.clipsToBounds = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"GRTuhaoRankTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:GRTuhaoRankTableCellID];
    [self startRequest];
    
    [self.titleLabel gr_addTapAction:^{
        [self tapTitleLabel];
    }];
    
    [self performSelector:@selector(tapTitleLabel) withObject:nil afterDelay:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)startRequest {
    [self showProgress];
    [[[GRRankListRequest alloc] init] startRequestComplete:^(GRTuhaoRankList *  _Nullable responseObject, NSError * _Nullable error) {
        [self hideProgress];
        if (error) {
            [self showFailure:@"获取数据失败，请稍后重试!"];
            return;
        }
        self.cellDataArray = responseObject.dataArray;
    }];
}

- (void)setCellDataArray:(NSArray<GRUserInfo *> *)cellDataArray {
    _cellDataArray = cellDataArray;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tapTitleLabel {
    [UIView gr_showOscillatoryAnimationWithLayer:self.titleLabel.layer type:GROscillatoryAnimationToBigger range:1.5];
}

#pragma - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GRTuhaoRankTableCell *cell = [tableView dequeueReusableCellWithIdentifier:GRTuhaoRankTableCellID forIndexPath:indexPath];
    cell.userInfo = self.cellDataArray[indexPath.row];
    cell.rankNumber = indexPath.row;
    return cell;
}


@end
