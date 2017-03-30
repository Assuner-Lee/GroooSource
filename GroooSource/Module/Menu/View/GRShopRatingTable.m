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
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
    self.delegate = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentInset = UIEdgeInsetsMake(44, 0, 44, 0);
}

- (void)startRequest {
    GRShopRatingListRequest *request = [[GRShopRatingListRequest alloc] initWithShopID:_shopID];
    if (request.cache) {
        
    }
    [request startRequestComplete:^(id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            return;
        }
    }];
}

@end
