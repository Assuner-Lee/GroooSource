//
//  GRJoinViewController.m
//  GroooSource
//
//  Created by Assuner on 2017/5/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRJoinViewController.h"

@interface GRJoinViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@end

@implementation GRJoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加入我们";
    self.contentTextView.layer.cornerRadius = 4.0f;
    self.contentTextView.clipsToBounds = YES;
    
    [self.titleLabel gr_addTapAction:^{
         [self tapTitleLabel];
    }];
    
    [self performSelector:@selector(tapTitleLabel) withObject:nil afterDelay:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tapTitleLabel {
    [UIView gr_showOscillatoryAnimationWithLayer:self.titleLabel.layer type:GROscillatoryAnimationToBigger range:1.5];
}

@end
