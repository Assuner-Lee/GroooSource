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
#import "GRContactUsController.h"
#import "GRWebViewController.h"

@interface GRAppInfoViewController () <SKStoreProductViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *appIconImgView;
@property (weak, nonatomic) IBOutlet UIView *appRatingView;
@property (weak, nonatomic) IBOutlet UIView *moreInfoView;
@property (weak, nonatomic) IBOutlet UIView *contactUsView;
@property (weak, nonatomic) IBOutlet UILabel *openSourceLabel;

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
    [self.appIconImgView gr_addTapAction:^{
        [self tapAppIconImgView];
    }];
    
    [self.appRatingView gr_addTapAction:^{
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

    }];
    
    [self.contactUsView gr_addTapAction:^{
        [self.navigationController pushViewController:[[GRContactUsController alloc] init] animated:YES];
    }];
    
    [self.moreInfoView gr_addTapAction:^{
        [self.navigationController pushViewController:[[GRAboutGroooController alloc] init] animated:YES];
    }];
    
    [self.openSourceLabel gr_addTapAction:^{
        [self.navigationController pushViewController:[[GRWebViewController alloc] initWithURL:kURL_OPEN_SOURCE title:@"开源地址"] animated:YES];
    }];
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
