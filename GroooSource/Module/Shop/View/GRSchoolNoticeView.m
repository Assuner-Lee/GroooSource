//
//  GRSchoolNoticeView.m
//  GroooSource
//
//  Created by Assuner on 2017/5/6.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRSchoolNoticeView.h"
#import "GRSchoolNoticeRequest.h"

@interface GRSchoolNoticeView ()

@property (nonatomic, strong) UIImageView *noticeImgView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) NSString *noticeText;

@end


@implementation GRSchoolNoticeView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 64, SCREEN_WIDTH, 30);
        [self startRequest];
    }
    return self;
}

- (void)startRequest {
    GRWEAK(self);
    [[[GRSchoolNoticeRequest alloc] init] startRequestComplete:^(NSDictionary *  _Nullable responseObject, NSError * _Nullable error) {
        GRSTRONG(self);
        if (error) {
            self.noticeText = @"获取学校公告失败";
            return;
        }
        self.noticeText = [NSString stringWithFormat:@"公告(滑动查看全部): %@", responseObject[@"data"]];
    }];
}

- (void)setNoticeText:(NSString *)noticeText {
    _noticeText = noticeText;
    [self initView];
}

- (void)initView {
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.noticeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    self.noticeImgView.image = [UIImage imageNamed:@"school_notice_icon"];
    [self addSubview:self.noticeImgView];
    
    NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:_noticeText attributes:[GRAppStyle attributeWithFont:[UIFont systemFontOfSize:14.0] color:[UIColor darkGrayColor]]];
    self.contentLabel = [UILabel new];
    self.contentLabel.attributedText = attributeText;
    
    CGFloat maxWidth = SCREEN_WIDTH - 33 - 40;
    CGFloat textWidth = MIN_SIZE(_contentLabel).width;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(33, 0, (textWidth < maxWidth ? textWidth : maxWidth), self.gr_height)];
    self.scrollView.contentSize = CGSizeMake(textWidth, self.scrollView.gr_height);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    //self.contentLabel.backgroundColor = [UIColor darkGrayColor];
    self.contentLabel.frame = CGRectMake(0, 0, self.scrollView.contentSize.width,  self.scrollView.contentSize.height);
    [self.scrollView addSubview:self.contentLabel];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(SCREEN_WIDTH - 30, -1.5, 30, 30);
    [self.closeBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"×" attributes:[GRAppStyle attributeWithFont:[UIFont systemFontOfSize:30.0] color:[UIColor lightGrayColor]]] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtn];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
    [self addSubview:line1];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 29.5, SCREEN_WIDTH, 0.5)];
    line2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
    [self addSubview:line2];
}

#pragma - Actions

- (void)close {
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        self.gr_height = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}

@end
