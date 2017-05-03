//
//  GRUserInfoController.m
//  GroooSource
//
//  Created by Assuner on 2017/5/3.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRUserInfoController.h"

@interface GRUserInfoController ()

@end

@implementation GRUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)init {
    if (self = [super init]) {
         self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"bar_item_user"] tag:0];
         self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
@end
