//
//  GRShopListViewController.m
//  GroooSource
//
//  Created by Assuner on 2017/2/23.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRShopListViewController.h"
#import "GRShopList.h"
#import "GRShopListRequest.h"
#import "GRShopListCell.h"
#import "GRMenuViewController.h"

static NSString *GRShopListCellID = @"GRShopListCellID";

@interface GRShopListViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) UITableView *shopListTableView;
@property (nonatomic, strong) NSArray<GRShop *> *shopDataArray;
@property (nonatomic, strong) NSMutableArray *takeoutArray;
@property (nonatomic, strong) NSMutableArray *marketArray;
@property (nonatomic, strong) NSArray<GRShop *> *cellDataArray;
@property (nonatomic, strong) GRShopListRequest *shopListRequest;

@property (nonatomic, strong) UISegmentedControl *titleSegmentedCtrl;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, assign) CGRect searchBarBeginFrame;
@property (nonatomic, assign) CGRect searchBarEndFrame;

@property (nonatomic, strong) UIBarButtonItem *searchItem;
@property (nonatomic, strong) UIBarButtonItem *closeItem;

@end

@implementation GRShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initRequest];
    [self startRequest];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[GRAppStyle mainColorWithAlpha:0.89]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[GRAppStyle transparentColor]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)init {
    if (self = [super init]) {
        self.takeoutArray = [[NSMutableArray alloc] init];
        self.marketArray = [[NSMutableArray alloc] init];
        self.searchBarBeginFrame = CGRectMake(SCREEN_WIDTH - 50, 0, 0, 30);
        self.searchBarEndFrame = CGRectMake(0, 0, SCREEN_WIDTH - 50, 30);
    }
    return self;
}

- (void)setupBarItem {
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"商家" image:[UIImage imageNamed:@"bar_item_shoplist"] tag:0];
    self.titleSegmentedCtrl = [[UISegmentedControl alloc] initWithItems:@[@"外卖", @"超市"]];
    [self.titleSegmentedCtrl setWidth:48 forSegmentAtIndex:0];
    [self.titleSegmentedCtrl setWidth:48 forSegmentAtIndex:1];
    self.titleSegmentedCtrl.backgroundColor = [UIColor clearColor];
    self.titleSegmentedCtrl.tintColor = [UIColor whiteColor];
    self.titleSegmentedCtrl.selectedSegmentIndex = 0;
    [self.titleSegmentedCtrl addTarget:self action:@selector(reloadWithSelectIndexOfSegmentCtrl) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.titleSegmentedCtrl;
    
    self.searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(touchRightBarItem)];
    self.closeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(touchRightBarItem)];
    self.navigationItem.rightBarButtonItem = self.searchItem;
}

- (void)initView {
    self.shopListTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.shopListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shopListTableView.backgroundColor = self.view.backgroundColor;
    self.shopListTableView.delegate = self;
    self.shopListTableView.dataSource = self;
    self.shopListTableView.scrollsToTop = YES;
    [self.view addSubview:self.shopListTableView];
    [self.shopListTableView registerNib:[UINib nibWithNibName:@"GRShopListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:GRShopListCellID];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:self.searchBarBeginFrame];
    self.searchBar.placeholder = @"查询";
    self.searchBar.delegate = self;
}

- (void)initRequest {
    self.shopListRequest = [[GRShopListRequest alloc] init];
    if (self.shopListRequest.cache) {
        self.shopDataArray = [self.shopListRequest.cache dataArray];
    }
}

- (void)startRequest {
    if (!self.shopListRequest.cache) {
        [self showProgress];
    }
    GRWEAK(self);
    [self.shopListRequest startRequestComplete:^(GRShopList *  _Nullable responseObject, NSError * _Nullable error) {
        GRSTRONG(self);
        [self hideProgress];
        if (error) {
            [self showTimeOut];
            return;
        }
        self.shopDataArray = responseObject.dataArray;
    }];
}

#pragma - setterOverride

- (void)setShopDataArray:(NSArray<GRShop *> *)shopDataArray {
    if (shopDataArray.count) {
        _shopDataArray = shopDataArray;
        [_takeoutArray removeAllObjects];
        [_marketArray removeAllObjects];
        for (GRShop *shopModel in _shopDataArray) {
            if ([shopModel.shopType isEqualToString:@"超市"]) {
                [_marketArray addObject:shopModel];
            } else {
                [_takeoutArray addObject:shopModel];
            }
        }
        [self reloadWithSelectIndexOfSegmentCtrl];
    }
}

- (void)setCellDataArray:(NSArray<GRShop *> *)cellDataArray {
    if (cellDataArray.count) {
        _cellDataArray = cellDataArray;
         [self.shopListTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma - action

- (void)reloadWithSelectIndexOfSegmentCtrl {
    if (self.titleSegmentedCtrl.selectedSegmentIndex == 0) {
        self.cellDataArray = _takeoutArray;
    } else {
        self.cellDataArray = _marketArray;
    }
}

- (void)touchRightBarItem {
    if ([self.navigationItem.rightBarButtonItem isEqual:self.searchItem]) {
        self.searchBar.hidden = YES;
        self.navigationItem.rightBarButtonItem = self.closeItem;
        GRWEAK(self);
        [UIView animateWithDuration:0.25 animations:^{
            GRSTRONG(self);
            self.searchBar.hidden = NO;
            self.searchBar.frame = self.searchBarEndFrame;
            self.navigationItem.titleView = self.searchBar;
            [self.searchBar becomeFirstResponder];
        }];
    } else {
        [self seachBarDisappear];
    }
}

- (void)seachBarDisappear {
    if ([self.navigationItem.rightBarButtonItem isEqual:self.closeItem]) {
        self.navigationItem.rightBarButtonItem = self.searchItem;
        self.searchBar.hidden = YES;
        self.searchBar.frame = self.searchBarBeginFrame;
        self.navigationItem.titleView = self.titleSegmentedCtrl;
        [self.searchBar resignFirstResponder];
        if (![self.searchBar.text isEqualToString:@""]) {
            self.searchBar.text = nil;
            [self reloadWithSelectIndexOfSegmentCtrl];
        }
    }
}

#pragma - searchBar

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSMutableArray *matchedArrray = [[NSMutableArray alloc] init];
    if (![searchText isEqualToString:@""]) {
        for (GRShop *shopModel in self.cellDataArray) {
            if ([shopModel.shopName rangeOfString:searchText].length) {
                [matchedArrray addObject:shopModel];
            }
        }
        self.cellDataArray = matchedArrray;
    } else {
        [self reloadWithSelectIndexOfSegmentCtrl];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self seachBarDisappear];
}

#pragma - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GRShopListCell *cell  = [tableView dequeueReusableCellWithIdentifier:GRShopListCellID forIndexPath:indexPath];
    cell.shopData = self.cellDataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellDataArray[indexPath.row].shopCellParams.shopCellHight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    GRMenuViewController *menuVC = [[GRMenuViewController alloc] initWithShop:self.cellDataArray[indexPath.row]];
    [self.navigationController pushViewController:menuVC animated:YES];
}

@end
