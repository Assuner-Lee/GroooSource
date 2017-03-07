//
//  GRAppDelegate.m
//  GroooSource
//
//  Created by 李永光 on 2017/2/6.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRAppDelegate.h"
#import "GRTabBarViewController.h"

@implementation GRAppDelegate

#pragma mark - app delegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self showRootView];
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
@end
