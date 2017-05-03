//
//  GRAppDelegate.m
//  GroooSource
//
//  Created by 李永光 on 2017/2/6.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRAppDelegate.h"
#import "GRTabBarViewController.h"
#import <LPDSplashScreenManager/LPDSplashScreenManager.h>


@implementation GRAppDelegate

#pragma mark - app delegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:0.7];
    NSString *imgUrlKey = [NSString stringWithFormat:@"splash_image%zd", (int)([UIScreen mainScreen].bounds.size.height*[UIScreen mainScreen].scale)];
    [LPDSplashScreenManager showSplashScreenWithImageUrl:getSplashImageUrlDic()[imgUrlKey] duration:2.0];
    [self showRootView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginVC) name:GRTokenInvaildNotification object:nil];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (void)showRootView {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[GRTabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showLoginVC {
   [GRRouter open:@"present->GRLoginViewController" params:nil completed:^{[MBProgressHUD gr_showFailure:@"请先登录"];}];
}

NSDictionary *getSplashImageUrlDic() {
    return @{@"splash_image960": @"http://upload-images.jianshu.io/upload_images/4133010-075eff58051efe97.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240", @"splash_image1136": @"http://upload-images.jianshu.io/upload_images/4133010-1f3d55efeca2aade.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240", @"splash_image1334": @"http://upload-images.jianshu.io/upload_images/4133010-87fb97284a1d034b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240", @"splash_image2208": @"http://upload-images.jianshu.io/upload_images/4133010-211af378d42916f8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"};
}

@end
