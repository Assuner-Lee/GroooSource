//
//  GRRouter.h
//  GroooSource
//
//  Created by Assuner on 2017/2/27.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRViewController.h"

@interface GRRouter : NSObject

+ (GRNavigationController *)hostViewController;
+ (void)pushViewController:(UIViewController *)aVC animated:(BOOL)animated;
+ (void)presentViewController:(UIViewController *)aVC animation:(GRTransitionType)type completion:(void (^)(void))completion;
+ (void)open:(NSString *)url params:(NSDictionary *)params completed:(GRBlankBlock)block;
+ (void)open:(NSString *)url params:(NSDictionary *)params;

@end
