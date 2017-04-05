//
//  GRSegmentHeadView.m
//  GroooSource
//
//  Created by Assuner on 2017/3/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRSegmentHeadView.h"

@interface GRSegmentHeadView ()

@property (nonatomic, strong) UIButton *title1;
@property (nonatomic, strong) UIButton *title2;
@property (nonatomic, strong) UIButton *title3;

@property (nonatomic, strong) UIColor *mainColor;

@end


@implementation GRSegmentHeadView

- (instancetype)initWithFrame:(CGRect)frame mainColor:(UIColor *)aColor {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[GRAppStyle viewBaseColor] colorWithAlphaComponent:0.6];
        self.mainColor = aColor;
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:effectview];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1)];
        line.backgroundColor = [GRAppStyle lineColor];
        [self addSubview:line];
        self.slideLine = [[UIView alloc] init];
        self.slideLine.backgroundColor = _mainColor;
        self.slideLine.layer.cornerRadius = 1.5;
        self.slideLine.clipsToBounds = YES;
        [self addSubview:self.slideLine];
        [self initLabels];
    }
    return self;
}

- (void)initLabels {
    self.title1 = [UIButton new];
    self.title2 = [UIButton new];
    self.title3 = [UIButton new];
    self.title1.tag = 1;
    self.title2.tag = 2;
    self.title3.tag = 3;
    self.title1.titleLabel.font = [GRAppStyle font13];
    self.title2.titleLabel.font = [GRAppStyle font13];
    self.title3.titleLabel.font = [GRAppStyle font13];
    [self.title1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.title2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.title3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.title1 setTitleColor:_mainColor forState:UIControlStateSelected];
    [self.title2 setTitleColor:_mainColor forState:UIControlStateSelected];
    [self.title3 setTitleColor:_mainColor forState:UIControlStateSelected];
    [self.title1 addTarget:self action:@selector(tapTitle:) forControlEvents:UIControlEventTouchUpInside];
    [self.title2 addTarget:self action:@selector(tapTitle:) forControlEvents:UIControlEventTouchUpInside];
    [self.title3 addTarget:self action:@selector(tapTitle:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_title1];
    [self addSubview:_title2];
    [self addSubview:_title3];
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    if (titleArray.count < 2) {
        return;
    }
    _titleArray = titleArray;
    _title1.frame = CGRectZero;
    _title2.frame = CGRectZero;
    _title3.frame = CGRectZero;
    
    if (titleArray.count == 2) {
        CGSize size1 = SIZE_OF_TEXT(titleArray[0], CGSizeZero, 13.0).size;
        CGSize size2 = SIZE_OF_TEXT(titleArray[1], CGSizeZero, 13.0).size;
        CGFloat distance = (SCREEN_WIDTH - size1.width - size2.width) / 2;
        _title1.frame = CGRectMake(0.5 * distance, 10, size1.width, size1.height + 6);
        _title2.frame = CGRectMake(_title1.gr_right + distance, 10, size2.width, size2.height + 6);
        [_title1 setTitle:titleArray[0] forState:UIControlStateNormal];
        [_title2 setTitle:titleArray[1] forState:UIControlStateNormal];
        
    }
    if (titleArray.count == 3) {
        CGSize size1 = SIZE_OF_TEXT(titleArray[0], CGSizeZero, 13.0).size;
        CGSize size2 = SIZE_OF_TEXT(titleArray[1], CGSizeZero, 13.0).size;
        CGSize size3 = SIZE_OF_TEXT(titleArray[2], CGSizeZero, 13.0).size;
        CGFloat distance = (SCREEN_WIDTH - size1.width - size2.width - size3.width) / 3;
        _title1.frame = CGRectMake(0.5 * distance, 10, size1.width, size1.height + 6);
        _title2.frame = CGRectMake(_title1.gr_right + 1 * distance, 10, size2.width, size2.height + 6);
        _title3.frame = CGRectMake(_title2.gr_right + 1 * distance, 10, size3.width, size3.height + 6);
        [_title1 setTitle:titleArray[0] forState:UIControlStateNormal];
        [_title2 setTitle:titleArray[1] forState:UIControlStateNormal];
        [_title3 setTitle:titleArray[2] forState:UIControlStateNormal];
    }
    _slideLine.frame = CGRectMake(_title1.gr_left, self.gr_height - 1 - 3, _title1.gr_width, 3);
}

#pragma - Actions 

- (void)tapTitle:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(changeWithTapIndex:)]) {
        [self.delegate changeWithTapIndex:(sender.tag - 1)];
    }
    [self selectIndex:sender.tag];
}

- (void)selectIndex:(NSUInteger)index {
    NSArray<UIButton *> *array = @[_title1, _title2, _title3];
    index = index < 1 ? 1 : index;
    for (UIButton *btn in array) {
        if ([btn isEqual:array[index - 1]]) {
            btn.selected = YES;
            [UIView gr_showOscillatoryAnimationWithLayer:btn.layer type:GROscillatoryAnimationToBigger range:1.3];
            [UIView animateWithDuration:0.1 animations:^{
                    _slideLine.gr_left = btn.gr_left;
                    _slideLine.gr_width = btn.gr_width;
                    
                }];
            
        } else {
            btn.selected = NO;
        }
    }
    
}

@end
