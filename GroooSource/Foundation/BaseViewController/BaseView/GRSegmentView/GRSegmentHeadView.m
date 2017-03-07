//
//  GRSegmentHeadView.m
//  GroooSource
//
//  Created by Assuner on 2017/3/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRSegmentHeadView.h"

@interface GRSegmentHeadView ()

@property (nonatomic, strong) UILabel *titleLabel1;
@property (nonatomic, strong) UILabel *titleLabel2;
@property (nonatomic, strong) UILabel *titleLabel3;

@end


@implementation GRSegmentHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initLabels];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1)];
        line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.12];
        [self addSubview:line];
        self.slideLine = [[UIView alloc] init];
        self.slideLine.backgroundColor = [GRAppStyle mainColor];
        self.slideLine.layer.cornerRadius = 1.5;
        self.slideLine.clipsToBounds = YES;
        [self addSubview:self.slideLine];
    }
    return self;
}

- (void)initLabels {
    self.titleLabel1 = [UILabel new];
    self.titleLabel2 = [UILabel new];
    self.titleLabel3 = [UILabel new];
    self.titleLabel1.font = [UIFont systemFontOfSize:13.0];
    self.titleLabel1.textColor = [UIColor darkGrayColor];
    self.titleLabel2.font = [UIFont systemFontOfSize:13.0];
    self.titleLabel2.textColor = [UIColor darkGrayColor];
    self.titleLabel3.font = [UIFont systemFontOfSize:13.0];
    self.titleLabel3.textColor = [UIColor darkGrayColor];
    [self addSubview:_titleLabel1];
    [self addSubview:_titleLabel2];
    [self addSubview:_titleLabel3];
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    if (titleArray.count < 2) {
        return;
    }
    _titleArray = titleArray;
    _titleLabel1.frame = CGRectZero;
    _titleLabel2.frame = CGRectZero;
    _titleLabel3.frame = CGRectZero;
    NSDictionary *attribute = [GRAppStyle attributeWithFont:[UIFont systemFontOfSize:13] color:[UIColor darkGrayColor]];
    if (titleArray.count == 2) {
        NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:titleArray[0] attributes:attribute];
        NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:titleArray[1] attributes:attribute];
        CGFloat distance = (SCREEN_WIDTH - string1.size.width - string2.size.width) / 3;
        _titleLabel1.frame = CGRectMake(0.5 * distance, 12, string1.size.width, string1.size.height);
        _titleLabel2.frame = CGRectMake(_titleLabel1.gr_right + 2 * distance, 12, string2.size.width, string2.size.height);
        _titleLabel1.attributedText = string1;
        _titleLabel2.attributedText = string2;
        
    }
    if (titleArray.count == 3) {
        NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:titleArray[0] attributes:attribute];
        NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:titleArray[1] attributes:attribute];
        NSAttributedString *string3 = [[NSAttributedString alloc] initWithString:titleArray[2] attributes:attribute];
        CGFloat distance = (SCREEN_WIDTH - string1.size.width - string2.size.width - string3.size.width) / 3;
        _titleLabel1.frame = CGRectMake(0.5 * distance, 12, string1.size.width, string1.size.height);
        _titleLabel2.frame = CGRectMake(_titleLabel1.gr_right + 1 * distance, 12, string2.size.width, string2.size.height);
        _titleLabel3.frame = CGRectMake(_titleLabel2.gr_right + 1 * distance, 12, string3.size.width, string3.size.height);
        _titleLabel1.attributedText = string1;
        _titleLabel2.attributedText = string2;
        _titleLabel3.attributedText = string3;
    }
    
    _slideLine.frame = CGRectMake(_titleLabel1.gr_left, self.gr_height - 1 - 3, _titleLabel1.gr_width, 3);
}

@end
