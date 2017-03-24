//
//  GRMenuMainView.m
//  GroooSource
//
//  Created by Assuner on 2017/3/24.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRMenuMainView.h"

@interface GRMenuMainView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *categoryTableView;
@property (nonatomic, strong) UITableView *menuDetailTableView;

@property (nonatomic, strong) NSMutableDictionary *menuDataDic;
@property (nonatomic, strong) NSMutableArray<NSString *> *categoryDataArray;
@property (nonatomic, strong) NSArray<GRMenu *> *menuDetailDataArray;

@end


@implementation GRMenuMainView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        self.menuDataDic = [[NSMutableDictionary alloc] init];
        self.categoryDataArray = [[NSMutableArray alloc] init];
        [self initView];
    }
    return self;
}

- (void)initView {
    _categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0.33*SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _categoryTableView.backgroundColor = [UIColor whiteColor];
    _categoryTableView.dataSource = self;
    _categoryTableView.delegate = self;
    _categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _categoryTableView.showsVerticalScrollIndicator = NO;
    _categoryTableView.contentInset = UIEdgeInsetsMake(44, 0, 44, 0);
    _categoryTableView.tag = 0;
    [self addSubview:_categoryTableView];
    
    _menuDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.33*SCREEN_WIDTH, 0, 0.67*SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _menuDetailTableView.backgroundColor = [UIColor whiteColor];
    _menuDetailTableView.dataSource = self;
    _menuDetailTableView.delegate = self;
    _menuDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _menuDetailTableView.showsVerticalScrollIndicator = YES;
    _menuDetailTableView.contentInset = UIEdgeInsetsMake(44, 0, 44, 0);
    _menuDetailTableView.tag = 1;
    [self addSubview:_menuDetailTableView];
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
    }
}

- (void)setMenuDetailDataArray:(NSArray<GRMenu *> *)menuDetailDataArray {
    if (menuDetailDataArray.count && _menuDetailDataArray != menuDetailDataArray) {
        _menuDetailDataArray = menuDetailDataArray;
        [_menuDetailTableView reloadData];
    }
}

#pragma - UITableView 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 0) {
        return _categoryDataArray.count;
    } else if (tableView.tag == 1) {
        return _menuDetailDataArray.count;
    }
    return 0;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//  
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//   
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 0) {
        self.menuDetailDataArray = _menuDataDic[_categoryDataArray[indexPath.row]];
    }
}

@end
