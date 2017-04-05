//
//  UIView+GRShortcut.h
//  GroooSource
//
//  Created by 李永光 on 2017/2/10.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GROscillatoryAnimationType){
    GROscillatoryAnimationToBigger,
    GROscillatoryAnimationToSmaller,
};

@interface UIView (GRShortcut)

@property (nonatomic) CGFloat gr_left;
@property (nonatomic) CGFloat gr_top;
@property (nonatomic) CGFloat gr_right;
@property (nonatomic) CGFloat gr_bottom;
@property (nonatomic) CGFloat gr_width;
@property (nonatomic) CGFloat gr_height;
@property (nonatomic) CGFloat gr_centerX;
@property (nonatomic) CGFloat gr_centerY;

+ (void)gr_showOscillatoryAnimationWithLayer:(CALayer *)layer type:(GROscillatoryAnimationType)type range:(CGFloat)range;

@end
