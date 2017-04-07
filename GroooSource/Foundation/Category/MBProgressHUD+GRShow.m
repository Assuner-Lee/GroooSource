//
//  MBProgressHUD+GRShow.m
//  GroooSource
//
//  Created by Assuner on 2017/4/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "MBProgressHUD+GRShow.h"


@implementation MBProgressHUD (GRShow)

+ (void)gr_show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (!text.length && !icon.length) {
        return;
    }
    [MBProgressHUD hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    if (icon) {
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: icon]];
    } else {
        hud.mode = MBProgressHUDModeText;
    }
    hud.detailsLabelFont = [GRAppStyle font16];
    hud.labelText = text;
    [view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1.0];
}

+ (void)gr_showProgress {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:NO];
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
}

+ (void)gr_hideProgress {
     [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
}

+ (void)gr_showMessage:(NSString *_Nonnull)text {
    [MBProgressHUD gr_show:text icon:nil view:[UIApplication sharedApplication].delegate.window];
}

+ (void)gr_showSuccess:(NSString *)text {
     [MBProgressHUD gr_show:text icon:@"MBProgressHud_success" view:[UIApplication sharedApplication].delegate.window];
}

+ (void)gr_showFailure:(NSString *)text {
    [MBProgressHUD gr_show:text icon:@"MBProgressHud_failure" view:[UIApplication sharedApplication].delegate.window];
}

@end
