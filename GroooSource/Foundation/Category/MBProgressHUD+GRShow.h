//
//  MBProgressHUD+GRShow.h
//  GroooSource
//
//  Created by Assuner on 2017/4/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (GRShow)

+ (void)gr_show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;
+ (void)gr_showProgress;
+ (void)gr_hideProgress;
+ (void)gr_showMessage:(NSString *)text;
+ (void)gr_showSuccess:(NSString *)text;
+ (void)gr_showFailure:(NSString *)text;

@end
