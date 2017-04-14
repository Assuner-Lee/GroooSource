//
//  GRShopRatingTable.m
//  GroooSource
//
//  Created by Assuner on 2017/3/30.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRShopRatingTable.h"
#import "GRShopRatingListRequest.h"
#import "GRShopRatingList.h"
#import "GRShopRatingLeftCell.h"
#import "GRShopRatingRightCell.h"

static NSString *GRShopRatingLeftCellID = @"GRShopRatingLeftCellID";
static NSString *GRShopRatingRightCellID = @"GRShopRatingRightCellID";

@interface GRShopRatingTable () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSUInteger shopID;
@property (nonatomic, strong) NSArray<GRShopRating *> *cellDataArray;

@end


@implementation GRShopRatingTable

- (instancetype)initWithShopID:(NSUInteger)shopID {
    if (self = [super init]) {
        _shopID = shopID;
        [self initView];
        [self startRequest];
    }
    return self;
}

- (void)initView {
    self.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
    self.delegate = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentInset = UIEdgeInsetsMake(64, 0, 44 + 49 + 44, 0);
    [self registerNib:[UINib nibWithNibName:@"GRShopRatingLeftCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:GRShopRatingLeftCellID];
    [self registerNib:[UINib nibWithNibName:@"GRShopRatingRightCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:GRShopRatingRightCellID];
}

- (void)startRequest {
    GRShopRatingListRequest *request = [[GRShopRatingListRequest alloc] initWithShopID:_shopID];
    if (request.cache) {
        self.cellDataArray = [request.cache dataArray];
    }
    GRWEAK(self);
    [request startRequestComplete:^(GRShopRatingList *  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            return;
        }
        GRSTRONG(self);
        self.cellDataArray = responseObject.dataArray;
    }];
}

#pragma - Override 

- (void)setCellDataArray:(NSArray<GRShopRating *> *)cellDataArray {
    if (cellDataArray.count) {
        _cellDataArray = cellDataArray;
        [self reloadData];
    }
}

#pragma - TableView 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0 ) {
        GRShopRatingLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:GRShopRatingLeftCellID forIndexPath:indexPath];
        cell.shopRating = self.cellDataArray[indexPath.row];
        return cell;
    } else {
        GRShopRatingRightCell *cell = [tableView dequeueReusableCellWithIdentifier:GRShopRatingRightCellID forIndexPath:indexPath];
        cell.shopRating = self.cellDataArray[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 140;
}

@end
