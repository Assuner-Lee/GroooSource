//
//  GRAboutGroooController.m
//  GroooSource
//
//  Created by Assuner on 2017/5/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRAboutGroooController.h"
#import "GRWebViewController.h"

@interface GRAboutGroooController ()

@property (weak, nonatomic) IBOutlet UIImageView *groooHeartImgView;
@property (weak, nonatomic) IBOutlet UIImageView *groooTextImgView;
@property (weak, nonatomic) IBOutlet UITextView *groooDescTextView;

@property (nonatomic, assign) BOOL isSpread;

@end

@implementation GRAboutGroooController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于咕噜校园";
    
    [self addGesture];
    
    self.groooDescTextView.layer.cornerRadius = 28;
    self.groooDescTextView.clipsToBounds = YES;
    self.groooDescTextView.hidden = YES;
    self.groooDescTextView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.02];
    self.groooDescTextView.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor;
    self.groooDescTextView.layer.borderWidth = 1.0f;
    
    self.groooTextImgView.gr_bottom = self.view.gr_height - 34;
    
    [self performSelector:@selector(heartImgViewMove) withObject:nil afterDelay:0.5];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addGesture {
    UITapGestureRecognizer *groooHeartImgViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGroooHeartImgView)];
    self.groooHeartImgView.userInteractionEnabled = YES;
    [self.groooHeartImgView addGestureRecognizer:groooHeartImgViewTap];
    
    UITapGestureRecognizer *groooTextImgViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGroooTextImgView)];
    self.groooTextImgView.userInteractionEnabled = YES;
    [self.groooTextImgView addGestureRecognizer:groooTextImgViewTap];
}

#pragma - Actions

- (void)tapGroooTextImgView {
    [self presentViewController:[GRWebViewController modalWebviewWithURL:kURL_GROOO title:@"网页版咕噜"] animation:GRTransitionTypePageUnCurl completion:nil];
}

- (void)tapGroooHeartImgView {
    [self heartImgViewMove];
    if (!self.isSpread) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            self.groooTextImgView.gr_bottom = self.view.gr_height - self.groooDescTextView.gr_height - 20;
        } completion:^(BOOL finished) {
            self.groooDescTextView.hidden = NO;
        }];
    } else {
        self.groooDescTextView.hidden = YES;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            self.groooTextImgView.gr_bottom = self.view.gr_height - 34;
        } completion:nil];
    }
    self.isSpread = !self.isSpread;
}

- (void)heartImgViewMove {
    [UIView gr_showOscillatoryAnimationWithLayer:self.groooHeartImgView.layer type:GROscillatoryAnimationToBigger range:1.3];
}

@end
