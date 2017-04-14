//
//  UIView+GRShortcut.m
//  GroooSource
//
//  Created by 李永光 on 2017/2/10.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "UIView+GRShortcut.h"

@implementation UIView (GRShortcut)

- (CGFloat)gr_left {
    return self.frame.origin.x;
}

- (void)setGr_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)gr_top {
    return self.frame.origin.y;
}

- (void)setGr_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)gr_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setGr_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)gr_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setGr_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)gr_width {
    return self.frame.size.width;
}

- (void)setGr_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)gr_height {
    return self.frame.size.height;
}

-(void)setGr_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)gr_centerX {
    return self.center.x;
}

- (void)setGr_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)gr_centerY {
    return self.center.y;
}

- (void)setGr_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

+ (void)gr_showOscillatoryAnimationWithLayer:(CALayer *)layer type:(GROscillatoryAnimationType)type range:(CGFloat)range {
    NSNumber *animationScale1 = type == GROscillatoryAnimationToBigger ? @(range = range ? : 1.15) : @(range = range ? : 0.7);
    NSNumber *animationScale2 = type == GROscillatoryAnimationToBigger ? @(0.92) : @(1.15);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}

@end
