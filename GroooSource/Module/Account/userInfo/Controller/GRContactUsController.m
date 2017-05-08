//
//  GRContactUsController.m
//  GroooSource
//
//  Created by Assuner on 2017/5/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRContactUsController.h"

@interface GRContactUsController ()

@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation GRContactUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系我们";
    self.infoView.layer.cornerRadius = 4.0f;
    self.infoView.clipsToBounds = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView gr_showOscillatoryAnimationWithLayer:self.titleLabel.layer type:GROscillatoryAnimationToBigger range:1.5];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
