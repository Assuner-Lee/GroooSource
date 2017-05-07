//
//  GRAppInfoViewController.m
//  GroooSource
//
//  Created by Assuner on 2017/5/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRAppInfoViewController.h"
#import <StoreKit/StoreKit.h>
#import "GRAboutGroooController.h"

@interface GRAppInfoViewController () <SKStoreProductViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *appIconImgView;
@property (weak, nonatomic) IBOutlet GRClickableView *appRatingView;
@property (weak, nonatomic) IBOutlet GRClickableView *moreInfoView;

@property (nonatomic, strong) SKStoreProductViewController *storeProductVC;

@end

@implementation GRAppInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于咕噜";
    [self addGesture];
    [self performSelector:@selector(tapAppIconImgView) withObject:nil afterDelay:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addGesture {
    UITapGestureRecognizer *appIconImgViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAppIconImgView)];
    self.appIconImgView.userInteractionEnabled = YES;
    [self.appIconImgView addGestureRecognizer:appIconImgViewTap];
    
    self.appRatingView.actionBlock = ^{
        self.storeProductVC = [[SKStoreProductViewController alloc] init];
        self.storeProductVC.delegate = self;
        NSDictionary *dict = [NSDictionary dictionaryWithObject:@"1124767297" forKey:SKStoreProductParameterITunesItemIdentifier];
        [self showProgress];
        GRWEAK(self);
        [self.storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {
            GRSTRONG(self);
            [self hideProgress];
            if (result) {
                [self presentViewController:self.storeProductVC animated:YES completion:nil];
            }
        }];
    };
    
    self.moreInfoView.actionBlock = ^{
        [self.navigationController pushViewController:[[GRAboutGroooController alloc] init] animated:YES];
    };
}

#pragma - Actions 

- (void)tapAppIconImgView {
    [UIView gr_showOscillatoryAnimationWithLayer:self.appIconImgView.layer type:GROscillatoryAnimationToBigger range:1.5];
}

#pragma - SKStoreProductViewControllerDelegate 

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)storeProductVC {
    [self.storeProductVC dismissViewControllerAnimated:YES completion:nil];
}

@end
