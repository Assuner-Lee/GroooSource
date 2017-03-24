//
//  GRMenuViewController.m
//  GroooSource
//
//  Created by Assuner on 2017/3/23.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRMenuViewController.h"
#import "GRMenuHeadView.h"


@interface GRMenuViewController ()

@property (nonatomic, strong) GRShop *shop;
@property (nonatomic, strong) GRMenuHeadView *headView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end


@implementation GRMenuViewController

- (instancetype)initWithShop:(GRShop *)shop {
    if (self = [super init]) {
        _shop = shop;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
