//
//  GRClickableView.m
//  GroooSource
//
//  Created by Assuner on 2017/5/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRClickableView.h"

@implementation GRClickableView

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
    [self addGestureRecognizer:tap];
}

- (void)action {
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
