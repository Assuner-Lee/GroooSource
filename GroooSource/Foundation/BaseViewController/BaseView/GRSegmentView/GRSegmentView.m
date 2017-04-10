//
//  GRSegmentView.m
//  GroooSource
//
//  Created by Assuner on 2017/3/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRSegmentView.h"
#import "GRSegmentHeadView.h"
#import "GRScrollView.h"

@interface GRSegmentView () <UIScrollViewDelegate, GRSegmentHeadViewDelegate>
@property (nonatomic, strong) NSArray<UIView *> *subViewsArray;
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@property (nonatomic, assign) CGFloat orignY;

@property (nonatomic, strong) GRSegmentHeadView *headView;
@property (nonatomic, strong) GRScrollView *baseView;
@property (nonatomic, assign) CGFloat subviewHight;
@property (nonatomic, assign) NSUInteger scrollCount;
@property (nonatomic, strong) UIColor *mainColor;

@end

@implementation GRSegmentView

- (instancetype)initWithSubviewArray:(NSArray<UIView *> *)subviewArray titleArray:(NSArray<NSString *> *)titleArray orignY:(CGFloat)orignY mainColor:(UIColor *)aColor {
    if (self = [super init]) {
        self.orignY = orignY;
        self.scrollCount = subviewArray.count;
        self.mainColor = aColor;
        if (!self.scrollCount) {
            return nil;
        }
        self.subViewsArray = subviewArray;
        if (subviewArray[0]) {
            self.subviewHight = subviewArray[0].gr_height;
        }
        self.frame = CGRectMake(0, _orignY, SCREEN_WIDTH, _subviewHight);
        [self initBaseView];
        [self initHeadView];
        
        self.titleArray = titleArray;
    }
    return self;
}

- (void)initHeadView {
    self.headView = [[GRSegmentHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) mainColor:self.mainColor];
    self.headView.delegate = self;
    [self.headView selectIndex:1];
    [self addSubview:self.headView];
   }

- (void)initBaseView {
    self.baseView = [[GRScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _subviewHight)];
    self.baseView.contentSize = CGSizeMake(SCREEN_WIDTH * _scrollCount, _subviewHight);
    self.baseView.pagingEnabled = YES;
    self.baseView.alwaysBounceVertical = NO;
    self.baseView.alwaysBounceHorizontal = YES;
    self.baseView.showsVerticalScrollIndicator = NO;
    self.baseView.showsHorizontalScrollIndicator = NO;
    self.baseView.delegate = self;
    [self addSubviews];
    [self addSubview:self.baseView];

}

- (void)addSubviews {
    for (UIView *view in _subViewsArray) {
        if (view) {
            [_baseView addSubview:view];
        }
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.baseView.backgroundColor = backgroundColor;
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    if (titleArray.count) {
        _titleArray = titleArray;
        _headView.titleArray = titleArray;
    }
}

#pragma - Scrollview 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect rect = self.headView.slideLine.frame;
    CGFloat orignX = scrollView.contentOffset.x / _subViewsArray.count  + (scrollView.frame.size.width/_titleArray.count - rect.size.width)/2;
    self.headView.slideLine.frame = CGRectMake(orignX, rect.origin.y, rect.size.width, rect.size.height);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = 1 + floor(scrollView.contentOffset.x / scrollView.gr_width);
    [self.headView selectIndex:index];
}

# pragma - GRSegmentHeadView

- (void)changeWithTapIndex:(NSUInteger)index {
   [UIView animateWithDuration:0.3 animations:^{
        [_baseView setContentOffset:CGPointMake(index * _baseView.gr_width,  0)];
   }];
}

@end
