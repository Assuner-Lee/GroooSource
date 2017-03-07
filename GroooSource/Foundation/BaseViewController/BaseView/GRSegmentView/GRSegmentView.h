//
//  GRSegmentView.h
//  GroooSource
//
//  Created by Assuner on 2017/3/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRSegmentView : UIView

@property (nonatomic, strong) NSArray<UIView *> *subViewsArray;
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@property (nonatomic, assign) CGFloat orignY;


- (instancetype)initWithSubviewArray:(NSArray<UIView *> *)subviewArray titleArray:(NSArray<NSString *> *)titleArray orignY:(CGFloat)orignY;

@end
