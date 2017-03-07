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

@end


@implementation GRSegmentHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[GRAppStyle viewBaseColor] colorWithAlphaComponent:0.6];
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:effectview];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1)];
        line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.12];
        [self addSubview:line];
        self.slideLine = [[UIView alloc] init];
        self.slideLine.backgroundColor = [GRAppStyle mainColor];
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
    NSDictionary *attribute = [GRAppStyle attributeWithFont:[UIFont systemFontOfSize:13] color:[UIColor darkGrayColor]];
    if (titleArray.count == 2) {
        NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:titleArray[0] attributes:attribute];
        NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:titleArray[1] attributes:attribute];
        CGFloat distance = (SCREEN_WIDTH - string1.size.width - string2.size.width) / 3;
        _title1.frame = CGRectMake(0.5 * distance, 10, string1.size.width, string1.size.height + 6);
        _title2.frame = CGRectMake(_title1.gr_right + 2 * distance, 10, string2.size.width, string2.size.height);
        [_title1 setAttributedTitle:string1 forState:UIControlStateNormal];
        [_title2 setAttributedTitle:string2 forState:UIControlStateNormal];
        
    }
    if (titleArray.count == 3) {
        NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:titleArray[0] attributes:attribute];
        NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:titleArray[1] attributes:attribute];
        NSAttributedString *string3 = [[NSAttributedString alloc] initWithString:titleArray[2] attributes:attribute];
        CGFloat distance = (SCREEN_WIDTH - string1.size.width - string2.size.width - string3.size.width) / 3;
        _title1.frame = CGRectMake(0.5 * distance, 10, string1.size.width, string1.size.height + 6);
        _title2.frame = CGRectMake(_title1.gr_right + 1 * distance, 10, string2.size.width, string2.size.height + 6);
        _title3.frame = CGRectMake(_title2.gr_right + 1 * distance, 10, string3.size.width, string3.size.height + 6);
        [_title1 setAttributedTitle:string1 forState:UIControlStateNormal];
        [_title2 setAttributedTitle:string2 forState:UIControlStateNormal];
        [_title3 setAttributedTitle:string3 forState:UIControlStateNormal];
       
    }
    
    _slideLine.frame = CGRectMake(_title1.gr_left, self.gr_height - 1 - 3, _title1.gr_width, 3);
}

#pragma - Actions 

- (void)tapTitle:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(changeWithTapIndex:)]) {
        [self.delegate changeWithTapIndex:(sender.tag - 1)];
    }
}

@end
