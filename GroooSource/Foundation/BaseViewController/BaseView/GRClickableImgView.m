//
//  GRClickableImgView.m
//  GroooSource
//
//  Created by Assuner on 2017/5/8.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRClickableImgView.h"

@implementation GRClickableImgView
- (instancetype)init {
    if (self = [super init]) {
        [self addGesture];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addGesture];
}

- (void)addGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (void)action {
    if (self.actionBlock) {
        self.actionBlock();
    }
}


@end
