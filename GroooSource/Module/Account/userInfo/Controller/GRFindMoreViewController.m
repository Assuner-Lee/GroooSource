//
//  GRFindMoreViewController.m
//  GroooSource
//
//  Created by Assuner on 2017/5/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRFindMoreViewController.h"
#import "GRJoinViewController.h"
#import "GRTuhaoRankController.h"

@interface GRFindMoreViewController ()

@property (weak, nonatomic) IBOutlet UIView *tuhaoRankView;
@property (weak, nonatomic) IBOutlet UIView *joinView;

@end

@implementation GRFindMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (instancetype)init {
    if (self = [super init]) {
         self.title = @"发现";
         self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)addGesture {
    [self.tuhaoRankView gr_addTapAction:^{
        [self.navigationController pushViewController:[[GRTuhaoRankController alloc] init] animated:YES];
    }];
    
    [self.joinView gr_addTapAction:^{
        [self.navigationController pushViewController:[[GRJoinViewController alloc] init] animated:YES];
    }];
}

@end
