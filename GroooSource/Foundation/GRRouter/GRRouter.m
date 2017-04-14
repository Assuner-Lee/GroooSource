//
//  GRRouter.m
//  GroooSource
//
//  Created by Assuner on 2017/2/27.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRRouter.h"
#import "GRNavigationController.h"
#import <objc/runtime.h>

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

+ (GRNavigationController *)hostViewController {
    return [[self sharedRouter] hostViewController];
}

- (GRNavigationController *)hostViewController {
    return (GRNavigationController *)(ROOT_VC.selectedViewController);
}

+ (void)pushViewController:(UIViewController *)aVC animated:(BOOL)animated {
    [[[self sharedRouter] hostViewController] pushViewController:aVC animated:animated];
}

+ (void)presentViewController:(UIViewController *)aVC animation:(GRTransitionType)type completion:(void (^)(void))completion {
    [(GRViewController *)([[self sharedRouter] hostViewController].topViewController) presentViewController:aVC animation:type completion:completion];
}

//@"push->GRMenuViewController?NO"
//@"present->GRLoginViewController?NO"
+ (void)open:(NSString *)url params:(NSDictionary *)params completed:(GRBlankBlock)block {
    if (url.length) {
        NSRange preRange = [url rangeOfString:@"->"];
        NSRange sufRange = [url rangeOfString:@"?"];
        NSString *openType = [url substringWithRange:NSMakeRange(0, preRange.location)];
        NSString *className = [url substringWithRange:NSMakeRange(preRange.location + preRange.length, (sufRange.length ? sufRange.location : url.length) - (preRange.location + preRange.length))];
        NSString *animatedType = sufRange.length ? [url substringWithRange:NSMakeRange(sufRange.location + sufRange.length , url.length - (sufRange.location + sufRange.length))] : nil;
        Class class = NSClassFromString(className);
        if (class && [class isSubclassOfClass:[UIViewController class]]) {
            UIViewController *vc = [[class alloc] init];
            if (vc) {
                unsigned int count;
                objc_property_t* props = class_copyPropertyList(class, &count);
                for (NSString *key in params.allKeys) {
                    if (params[key]) {
                        BOOL isMatched = NO;
                        for (int i = 0; i < count; i++) {
                            objc_property_t property = props[i];
                            const char * name = property_getName(property);
                            NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
                            if ([propertyName isEqualToString:key]) {
                                isMatched = YES;
                                const char * attributesChar = property_getAttributes(property);
                                NSString *attributesString = [NSString stringWithCString:attributesChar encoding:NSUTF8StringEncoding];
                                NSArray * attributesArray = [attributesString componentsSeparatedByString:@","];
                                NSString *classAttribute = [attributesArray objectAtIndex:0];
                                NSString * propertyClassString = [classAttribute substringWithRange:NSMakeRange(3, classAttribute.length - 1 - 3)] ;
                                Class propertyClass = NSClassFromString(propertyClassString);
                                if (propertyClass && [params[key] isKindOfClass:propertyClass]) {
                                    [vc setValue:params[key] forKey:key];
                                } else {
                                    [NSException raise:@"GRRouterParamsError" format:@"param:value of (%@) isn't kind of class (%@) but (%@)", key, propertyClassString, NSStringFromClass([params[key] class])];
                                }
                                break;
                            }
                      }
                        if (!isMatched) {
                             [NSException raise:@"GRRouterParamsError" format:@"param:key named (%@) doesn't exist in class (%@)", key, className];
                        }
                  }
              }
                free(props);
                if ([openType isEqualToString:@"push"]) {
                    [self pushViewController:vc animated:([animatedType isEqualToString:@"YES"] || [animatedType isEqualToString:@"NO"]) ? animatedType.boolValue : YES];
                } else if ([openType isEqualToString:@"present"]) {
                    [self presentViewController:vc animation:[animatedType isEqualToString:@"NO"] ? GRTransitionTypeNone : GRTransitionTypeRippleEffect completion:block];
                } else {
                    [NSException raise:@"GRRouterOpenTypeError" format:@"openType:(%@) doesn't exist", openType];
                }
            } else {
                [NSException raise:@"GRRouterClassError" format:@"class:(%@) can't init", className];
            }
        } else {
            [NSException raise:@"GRRouterClassError" format:@"class:(%@) doesn't exist or isn't subclass of UIViewController", className];
        }
    }
}

+ (void)open:(NSString *)url params:(NSDictionary *)params {
    [self open:url params:params completed:nil];
}


@end
