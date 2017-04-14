//
//  GRViewController.h
//  GroooSource
//
//  Created by 李永光 on 2017/2/8.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRNetRequestObject.h"
#import "GRNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GRTransitionType) {
    GRTransitionTypeNone,
    GRTransitionTypeFade,
    GRTransitionTypeMoveIn,
    GRTransitionTypePush,
    GRTransitionTypeReveal,
    GRTransitionTypePageCurl,
    GRTransitionTypePageUnCurl,
    GRTransitionTypeRippleEffect,
    GRTransitionTypeSuckEffect,
    GRTransitionTypeCube,
    GRTransitionTypeOglFlip
};

@interface GRViewController : UIViewController

- (void)showProgress;
- (void)hideProgress;
- (void)showMessage:(NSString *)text;
- (void)show:(NSString *)text icon:(NSString *)icon;
- (void)showSuccess:(NSString *)text;
- (void)showTimeOut;

- (void)presentViewController:(UIViewController *)viewController animation:(GRTransitionType)type completion:(void (^ __nullable)(void))completion;
- (void)dismissViewControllerWithAnimation:(GRTransitionType)type completion:(void (^ __nullable)(void))completion;
- (void)setupBarItem;
- (void)back;
- (void)addObservedNotification;

@end

NS_ASSUME_NONNULL_END
