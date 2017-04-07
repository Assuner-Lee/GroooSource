//
//  GRMenuMainView.m
//  GroooSource
//
//  Created by Assuner on 2017/3/24.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRMenuMainView.h"
#import "GRMenuCategoryCell.h"
#import "GRNotification.h"

static NSString *GRMenuCategoryCellID = @"GRMenuCategoryCellID";
static NSString *GRMenuDetailCellID = @"GRMenuDetailCellID";

@interface GRMenuMainView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *categoryTableView;
@property (nonatomic, strong) UITableView *menuDetailTableView;

@property (nonatomic, strong) NSMutableDictionary *menuDataDic;
@property (nonatomic, strong) NSMutableArray<NSString *> *categoryDataArray;
@property (nonatomic, strong) NSArray<GRMenu *> *menuDetailDataArray;
@property (nonatomic, assign) NSUInteger shopStatus;

@end


@implementation GRMenuMainView

- (instancetype)initWithShopStatus:(NSUInteger)shopStatus {
    if (self = [super init]) {
        _shopStatus = shopStatus;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        self.menuDataDic = [[NSMutableDictionary alloc] init];
        self.categoryDataArray = [[NSMutableArray alloc] init];
        [self initView];
    }
    return self;
}

- (void)initView {
    _categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _categoryTableView.backgroundColor = [UIColor whiteColor];
    _categoryTableView.dataSource = self;
    _categoryTableView.delegate = self;
    _categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _categoryTableView.showsVerticalScrollIndicator = NO;
    _categoryTableView.contentInset = UIEdgeInsetsMake(44, 0, 44 + 49 + 44, 0);
    _categoryTableView.tag = 0;
    [_categoryTableView registerNib:[UINib nibWithNibName:@"GRMenuCategoryCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:GRMenuCategoryCellID];
    [self addSubview:_categoryTableView];
    
    _menuDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 80, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _menuDetailTableView.backgroundColor = [UIColor whiteColor];
    _menuDetailTableView.dataSource = self;
    _menuDetailTableView.delegate = self;
    _menuDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _menuDetailTableView.showsVerticalScrollIndicator = YES;
    _menuDetailTableView.contentInset = UIEdgeInsetsMake(44, 0, 44 + 49 + 44, 0);
    _menuDetailTableView.tag = 1;
    [_menuDetailTableView registerNib:[UINib nibWithNibName:@"GRMenuDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:GRMenuDetailCellID];
    [self addSubview:_menuDetailTableView];
}

- (void)reload {
    [self.menuDetailTableView reloadData];
}

- (void)setMenuDataArray:(NSArray<GRMenu *> *)menuDataArray {
    if (menuDataArray.count) {
         _menuDataArray = menuDataArray;
        [_menuDataDic removeAllObjects];
        [_categoryDataArray removeAllObjects];
        for (GRMenu *menuModel in menuDataArray) {
            if ([_categoryDataArray containsObject:menuModel.menuCategory]) {
                NSMutableArray *oldArray = _menuDataDic[menuModel.menuCategory];
                [oldArray addObject:menuModel];
            } else {
                NSMutableArray *newArray = [[NSMutableArray alloc] init];
                [newArray addObject:menuModel];
                [_menuDataDic setObject:newArray forKey:menuModel.menuCategory];
                [_categoryDataArray addObject:menuModel.menuCategory];
            }
        }
        [_categoryTableView reloadData];
        [self tableView:_categoryTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [_categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        [[NSNotificationCenter defaultCenter] postNotificationName:GRMenuReloadedNotification object:nil];
    }
}

- (void)setMenuDetailDataArray:(NSArray<GRMenu *> *)menuDetailDataArray {
    if (menuDetailDataArray.count && _menuDetailDataArray != menuDetailDataArray) {
        _menuDetailDataArray = menuDetailDataArray;
        [_menuDetailTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma - UITableView 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 0) {
        return _categoryDataArray.count;
    } else {
        return _menuDetailDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 0) {
        GRMenuCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:GRMenuCategoryCellID forIndexPath:indexPath];
        cell.categoryLabel.text = self.categoryDataArray[indexPath.row];
        return cell;
    } else {
        GRMenuDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:GRMenuDetailCellID forIndexPath:indexPath];
        [cell setMenu:self.menuDetailDataArray[indexPath.row] shopStatus:_shopStatus];
        cell.selectBlock = self.selectBlock;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        return 50;
    } else {
        return 100;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 0) {
        self.menuDetailDataArray = _menuDataDic[_categoryDataArray[indexPath.row]];
    }
}

@end
