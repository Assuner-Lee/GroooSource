//
//  GRFindMoreViewController.m
//  GroooSource
//
//  Created by Assuner on 2017/5/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRFindMoreViewController.h"
#import "GRJoinViewController.h"

@interface GRFindMoreViewController ()

@property (weak, nonatomic) IBOutlet GRClickableView *tuhaoRankView;
@property (weak, nonatomic) IBOutlet GRClickableView *joinView;

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
    self.tuhaoRankView.actionBlock = ^{
        
    };
    
    self.joinView.actionBlock = ^{
        [self.navigationController pushViewController:[[GRJoinViewController alloc] init] animated:YES];
    };
}

@end
