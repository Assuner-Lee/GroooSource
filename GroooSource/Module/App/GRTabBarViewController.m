//
//  GRTabBarViewController.m
//  GroooSource
//
//  Created by Assuner on 2017/2/27.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRTabBarViewController.h"
#import "GRShopListViewController.h"
#import "GRLoginViewController.h"
#import "GROrderListViewController.h"

@interface GRTabBarViewController ()

@end

@implementation GRTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [GRAppStyle mainColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)init {
    if (self = [super init]) {
        UINavigationController *shopListNVC = [[UINavigationController alloc] initWithRootViewController:[[GRShopListViewController alloc] init]];
        UINavigationController *orderListNVC = [[UINavigationController alloc] initWithRootViewController:[[GROrderListViewController alloc] init]];
        GRLoginViewController *login = [GRLoginViewController new];
        self.viewControllers = @[shopListNVC, orderListNVC,login];
    }
    return self;
}

@end
