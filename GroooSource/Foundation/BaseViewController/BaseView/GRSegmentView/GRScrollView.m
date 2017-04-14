//
//  GRScrollView.m
//  GroooSource
//
//  Created by Assuner on 2017/4/10.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRScrollView.h"

@implementation GRScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.contentOffset.x <= 0) {
        if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]) {
            return YES;
        }
    }
    return NO;
}
@end
