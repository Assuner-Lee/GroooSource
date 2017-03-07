//
//  GRViewController.m
//  GroooSource
//
//  Created by 李永光 on 2017/2/8.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRViewController.h"
#import "MBProgressHUD.h"

@interface GRViewController ()

@end

@implementation GRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GRAppStyle viewBaseColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[GRAppStyle attributeWithFont:[GRAppStyle font16] color:[UIColor whiteColor]]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[GRAppStyle mainColorWithAlpha:0.89]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[GRAppStyle transparentColor]]];
    [self.navigationController setHidesBottomBarWhenPushed:YES];
    
    [self setupBarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupBarItem {
    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        flexSpace.width = -5;
        self.navigationItem.leftBarButtonItems = @[flexSpace, backBtn];
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showProgress {
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideProgress {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)showMessage:(NSString *_Nonnull)text {
    if ([NSString gr_isInvalid:text]) {
        return;
    }
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelFont = [GRAppStyle font16];
    hud.detailsLabelText = text;
    [self.view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1.0];
}

- (void)show:(NSString *)text icon:(NSString *)icon {
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: icon]];
    hud.detailsLabelFont = [GRAppStyle font16];
    hud.labelText = text;
    [self.view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1.0];
}

- (void)showSuccess:(NSString *)text {
    [self show:text icon:@"MBProgressHud_success"];
}

- (void)showFailure:(NSString *)text {
    [self show:text icon:@"MBProgressHud_failure"];
}

- (void)showTimeOut {
    [self showFailure:@"请求超时"];
}

#pragma - AnimationTransition

- (NSString *)stringWithTransitionType:(GRTransitionType)type {
    switch (type) {
        case GRTransitionTypeNone:
            return @"none";
        case GRTransitionTypeFade:
            return @"fade";
        case GRTransitionTypeMoveIn:
            return @"moveIn";
        case GRTransitionTypePush:
            return @"push";
        case GRTransitionTypeReveal:
            return @"reveal";
        case GRTransitionTypePageCurl:
            return @"pageCurl";
        case GRTransitionTypePageUnCurl:
            return @"pageUnCurl";
        case GRTransitionTypeRippleEffect:
            return @"rippleEffect";
        case GRTransitionTypeSuckEffect:
            return @"suckEffect";
        case GRTransitionTypeCube:
            return @"cube";
        case GRTransitionTypeOglFlip:
            return @"oglFlip";
        default:
            return @"none";
    }
}

- (void)presentViewController:(UIViewController *)viewController animation:(GRTransitionType)type completion:(void (^)(void))completion {
    if (GRTransitionTypeNone == type) {
        [self presentViewController:viewController animated:NO completion:completion];
        return;
    }
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.7;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = [self stringWithTransitionType:type];
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:viewController animated:NO completion:completion];
}

- (void)dismissViewControllerWithAnimation:(GRTransitionType)type completion:(void (^)(void))completion {
    if (GRTransitionTypeNone == type) {
        [self dismissViewControllerAnimated:NO completion:completion];
        return;
    }
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = [self stringWithTransitionType:type];
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:completion];
         
}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
