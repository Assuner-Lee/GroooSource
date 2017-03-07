////
////  GRRouter.m
////  GroooSource
////
////  Created by Assuner on 2017/2/27.
////  Copyright © 2017年 Assuner. All rights reserved.
////
//
//#import "GRRouter.h"
//#import "GRViewController.h"
//
//@interface GRRouter ()
//
//@property (nonatomic, strong) UIViewController *hostViewController;
//
//@end
//
//@implementation GRRouter
//
//+ (instancetype)sharedRouter {
//    static GRRouter *router = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        router = [[GRRouter alloc] init];
//    });
//    return router;
//}
//
//- (UIViewController *)hostViewController {
//    if (!_hostViewController) {
//        _hostViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
//    }
//    return _hostViewController;
//}
//
//+ (void)pushViewController:(UIViewController *)aVC animated:(BOOL)animated {
//    [(UINavigationController *)[[self sharedRouter]hostViewController] pushViewController:aVC animated:animated];
//}
//
//+ (void)presentViewController:(UIViewController *)aVC animation:(GRTransitionType)type {
//
//}
//}
//@end
