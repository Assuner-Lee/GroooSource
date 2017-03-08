//
//  GRSegmentView.h
//  GroooSource
//
//  Created by Assuner on 2017/3/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRSegmentView : UIView

- (instancetype)initWithSubviewArray:(NSArray<UIView *> *)subviewArray titleArray:(NSArray<NSString *> *)titleArray orignY:(CGFloat)orignY mainColor:(UIColor *)aColor;

@end
