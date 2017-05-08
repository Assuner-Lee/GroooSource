//
//  GRAutherInfoController.m
//  GroooSource
//
//  Created by Assuner on 2017/5/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRAutherInfoController.h"
#import "GRWebViewController.h"

@interface GRAutherInfoController ()

@property (weak, nonatomic) IBOutlet GRClickableImgView *appAutherImgView;
@property (weak, nonatomic) IBOutlet GRClickableImgView *serviceAutherImgView;
@property (weak, nonatomic) IBOutlet UILabel *appAutherNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceAutherNameLabel;
@property (weak, nonatomic) IBOutlet GRClickableView *blogView;
@property (weak, nonatomic) IBOutlet GRClickableView *weiboView;
@property (weak, nonatomic) IBOutlet GRClickableView *contactView;
@property (weak, nonatomic) IBOutlet UIView *contactInfoView;

@property (nonatomic, assign) BOOL isAvatarSpread;
@property (nonatomic, assign) BOOL isContactInfoSpread;

@end

@implementation GRAutherInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGesture];
    self.title = @"关于作者";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.appAutherImgView.layer.cornerRadius = self.appAutherImgView.gr_width / 2.0;
    self.appAutherImgView.clipsToBounds = YES;
    
    self.serviceAutherImgView.layer.cornerRadius = self.serviceAutherImgView.gr_width / 2.0;
    self.serviceAutherImgView.clipsToBounds = YES;
    self.serviceAutherNameLabel.hidden = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.contactInfoView.gr_height = 0;
        self.contactInfoView.clipsToBounds = YES;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView gr_showOscillatoryAnimationWithLayer:self.appAutherImgView.layer type:GROscillatoryAnimationToBigger range:1.5];
        [self tapAppAutherImgView];
        [self performSelector:@selector(tapAppAutherImgView) withObject:nil afterDelay:1.0];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)setupBarItem {
    [super setupBarItem];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"GitHub" style:UIBarButtonItemStylePlain target:self action:@selector(goGitPage)];
}

- (void)addGesture {
    self.appAutherImgView.actionBlock = ^{
        [self tapAppAutherImgView];
    };
    
    self.serviceAutherImgView.actionBlock = ^{
        [self.navigationController pushViewController:[[GRWebViewController alloc] initWithURL:kURL_SERVICE_AUTHER_GIT title:@"后端作者负责哥的GitHub"] animated:YES];
    };
    
    self.contactView.actionBlock = ^{
        if (!self.isContactInfoSpread) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                self.contactInfoView.gr_height = 150;
            } completion:nil];
        } else {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                self.contactInfoView.gr_height = 0;
            } completion:nil];
        }
        self.isContactInfoSpread = !self.isContactInfoSpread;
    };
    
    self.blogView.actionBlock = ^{
        [self.navigationController pushViewController:[[GRWebViewController alloc] initWithURL:kURL_BLOG title:@"技术博客"] animated:YES];
    };
    
    self.weiboView.actionBlock = ^{
        [self.navigationController pushViewController:[[GRWebViewController alloc] initWithURL:kURL_WEIBO title:@"微博"] animated:YES];
    };
}

#pragma - Actions 

- (void)tapAppAutherImgView {
    if (!self.isAvatarSpread) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            self.appAutherImgView.gr_centerX = 0.25 * self.view.gr_width;
            self.serviceAutherImgView.gr_centerX = 0.75 * self.view.gr_width;
            
            self.appAutherNameLabel.gr_centerX = 0.25 * self.view.gr_width;
            self.serviceAutherNameLabel.gr_centerX = 0.75 * self.view.gr_width;
            self.serviceAutherNameLabel.hidden = NO;
        } completion:nil];
 
    } else {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            self.appAutherImgView.gr_centerX = 0.5 * self.view.gr_width;
            self.serviceAutherImgView.gr_centerX = 0.5 * self.view.gr_width;
            self.appAutherNameLabel.gr_centerX = 0.5 * self.view.gr_width;
            self.serviceAutherNameLabel.gr_centerX = 0.5 * self.view.gr_width;
            self.serviceAutherNameLabel.hidden = YES;
        } completion:nil];
    }
    self.isAvatarSpread = !self.isAvatarSpread;
}


- (void)goGitPage {
     [self presentViewController:[GRWebViewController modalWebviewWithURL:kURL_APP_AUTHER_GIT title:@"iOS小学生的GitHub"] animation:GRTransitionTypePageUnCurl completion:nil];
}

@end
