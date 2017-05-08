//
//  UIView+GRClickable.m
//  GroooSource
//
//  Created by Assuner on 2017/5/8.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "UIView+GRClickable.h"
#import <objc/runtime.h>

@implementation UIView (GRClickable)

- (void)gr_addTapAction:(GRTapActionBlock)actionBlock {
    [self gr_addGesture];
    objc_setAssociatedObject(self, @selector(gr_action), actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)gr_action {
    GRTapActionBlock block = objc_getAssociatedObject(self, _cmd);
    if (block) {
        block();
    }
}

- (void)gr_addGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gr_action)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

@end
