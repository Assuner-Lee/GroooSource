//
//  GRSegmentView.m
//  GroooSource
//
//  Created by Assuner on 2017/3/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRSegmentView.h"

@interface GRSegmentView ()

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIScrollView *baseView;
@property (nonatomic, assign) CGFloat subviewHight;
@property (nonatomic, assign) NSUInteger ScrollCount;

@end

@implementation GRSegmentView

- (instancetype)initWithSubviewArray:(NSArray<UIView *> *)subviewArray titleArray:(NSArray<NSString *> *)titleArray orignY:(CGFloat)orignY{
    if (self = [super init]) {
        self.orignY = orignY;
        self.ScrollCount = subviewArray.count;
        if (!subviewArray.count) {
            return nil;
        }
        self.subviewHight = subviewArray[0].gr_height;
    }
    return self;
}

- (void)initView {
    self.frame = CGRectMake(0, _orignY, SCREEN_WIDTH, _subviewHight + 44);
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    self.headView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.headView];
    
    
    self.baseView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, _subviewHight)];
    self.baseView.contentSize = CGSizeMake(SCREEN_WIDTH * _ScrollCount, _subviewHight);
    self.baseView.pagingEnabled = YES;
    [self addSubview:self.baseView];
}

- (void)addSubviews {
    for (int i = 0; i < _ScrollCount; i++) {
        UIView *view = _subViewsArray[i];
        view.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, _subviewHight);
        [_baseView addSubview:view];
    }
}

@end
