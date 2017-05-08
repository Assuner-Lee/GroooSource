//
//  UIView+GRClickable.h
//  GroooSource
//
//  Created by Assuner on 2017/5/8.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GRTapActionBlock)(void);

@interface UIView (GRClickable)

- (void)gr_addTapAction:(GRTapActionBlock)actionBlock;

@end
