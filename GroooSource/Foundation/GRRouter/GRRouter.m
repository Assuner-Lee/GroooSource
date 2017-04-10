//
//  GRRouter.m
//  GroooSource
//
//  Created by Assuner on 2017/2/27.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRRouter.h"
#import "GRNavigationController.h"
#import "GRTabBarViewController.h"

@interface GRRouter ()

@property (nonatomic, strong) GRNavigationController *hostViewController;

@end

@implementation GRRouter

+ (instancetype)sharedRouter {
    static GRRouter *router = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[GRRouter alloc] init];
    });
    return router;
}


- (GRNavigationController *)hostViewController {
    return ((GRNavigationController *)((GRTabBarViewController *)MAIN_WINDOW.rootViewController).selectedViewController);
}

+ (void)pushViewController:(UIViewController *)aVC animated:(BOOL)animated {
    [[[self sharedRouter] hostViewController] pushViewController:aVC animated:animated];
}

+ (void)presentViewController:(UIViewController *)aVC animation:(GRTransitionType)type completion:(void (^)(void))completion {
    [(GRViewController *)([[self sharedRouter] hostViewController].topViewController) presentViewController:aVC animation:type completion:completion];
}

//@"push->GRMenuViewController?YES"
//@"present->GRLoginViewController?NO"
+ (void)open:(NSString *)url params:(NSDictionary *)params completed:(GRBlankBlock)block {
    if (url.length) {
        NSRange preRange = [url rangeOfString:@"->"];
        NSRange sufRange = [url rangeOfString:@"?"];
        NSString *openType = [url substringWithRange:NSMakeRange(0, preRange.location)];
        NSString *className = [url substringWithRange:NSMakeRange(preRange.location + preRange.length, (sufRange.length ? sufRange.location : url.length) - (preRange.location + preRange.length))];
        NSString *animatedType = [url substringWithRange:NSMakeRange(sufRange.location + sufRange.length , url.length - (sufRange.location + sufRange.length))];
        Class class = NSClassFromString(className);
        if (class && [class isSubclassOfClass:[GRViewController class]]) {
            GRViewController *vc = [class routerObjWithParams:params];
            if (vc) {
                if ([openType isEqualToString:@"push"]) {
                    [self pushViewController:vc animated:([animatedType isEqualToString:@"YES"] || [animatedType isEqualToString:@"NO"]) ? animatedType.boolValue : YES];
                }
                if ([openType isEqualToString:@"present"]) {
                    [self presentViewController:vc animation:[animatedType isEqualToString:@"NO"] ? GRTransitionTypeNone : GRTransitionTypeRippleEffect completion:block];
                }
            } else {
                [NSException raise:@"GRouterClassError" format:@"class:(%@) can't init", className];
            }
        } else {
            [NSException raise:@"GRouterClassError" format:@"class:(%@) doesn't exist or isn't subclass of GRViewController", className];
        }
    }
}

+ (void)open:(NSString *)url params:(NSDictionary *)params {
    [self open:url params:params completed:nil];
}


@end
