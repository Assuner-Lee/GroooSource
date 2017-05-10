//
//  GRRateViewController.m
//  GroooSource
//
//  Created by Assuner on 2017/5/10.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRRateViewController.h"
#import "GRStarsView.h"

@interface GRRateViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *shopLogo;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (weak, nonatomic) IBOutlet UIView *starsBaseView;
@property (weak, nonatomic) IBOutlet UILabel *badRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *midRateLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (strong, nonatomic) GRStarsView *starsView;

@property (nonatomic, strong) GROrder *order;

@end

@implementation GRRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
    [self addGesture];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView gr_showOscillatoryAnimationWithLayer:_shopLogo.layer type:GROscillatoryAnimationToBigger range:1.3];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)initWithOrder:(GROrder *)order {
    if (self = [self init]) {
        self.order = order;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"评价";
    }
    return self;
}

- (void)addObservedNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)initView {
    [_shopLogo setImageWithURL:[NSURL URLWithString:[_order.shop.shopLogo stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"shop_placeholder"]];
    
    self.shopLogo.layer.cornerRadius = self.shopLogo.gr_width / 2;
    self.shopLogo.clipsToBounds = YES;
    self.shopLogo.layer.borderColor = [GRAppStyle mainColor].CGColor;
    self.shopLogo.layer.borderWidth = 2.0f;
    
    self.shopNameLabel.text = _order.shop.shopName;
    
    self.starsView = [[GRStarsView alloc] initWithStarSize:CGSizeMake(30, 30) margin:10 numberOfStars:5];
    self.starsView.score = 5.0;
    self.starsView.allowDragSelect = YES;
    [self.starsBaseView addSubview:self.starsView];
    
    [self configRateLabel:self.badRateLabel WithColor:[UIColor redColor]];
    [self configRateLabel:self.goodRateLabel WithColor:[GRAppStyle mainColor]];
    [self configRateLabel:self.midRateLabel WithColor:[GRAppStyle orangeColor]];
    self.goodRateLabel.backgroundColor = [GRAppStyle mainColor];
    self.goodRateLabel.textColor = [UIColor whiteColor];
    
    self.textView.layer.cornerRadius = 4.0f;
    self.textView.layer.borderColor = [GRAppStyle lineColor].CGColor;
    self.textView.layer.borderWidth = 1.2f;
    self.textView.clipsToBounds = YES;
    self.textView.delegate = self;
    
    self.submitBtn.layer.cornerRadius = self.submitBtn.gr_height / 2;
    self.submitBtn.clipsToBounds = YES;
    [self.submitBtn setBackgroundImage:[UIImage imageWithColor:[GRAppStyle orangeColor]] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[UIImage imageWithColor:[[GRAppStyle orangeColor] colorWithAlphaComponent:0.7]] forState:UIControlStateHighlighted];
    [self.submitBtn setBackgroundImage:[UIImage imageWithColor:[[GRAppStyle orangeColor] colorWithAlphaComponent:0.4]] forState:UIControlStateDisabled];
}

- (void)configRateLabel:(UILabel *)aLabel WithColor:(UIColor *)aColor {
    aLabel.textColor = aColor;
    aLabel.layer.cornerRadius = aLabel.gr_height / 2;
    aLabel.layer.borderWidth = 1.0;
    aLabel.layer.borderColor = aColor.CGColor;
    aLabel.clipsToBounds = YES;
}

- (void)addGesture {
    GRWEAK(self);
    self.starsView.tappedActionBlock = ^(CGFloat score) {
        GRSTRONG(self);
        if (score > 4.3) {
            self.goodRateLabel.backgroundColor = [GRAppStyle mainColor];
            self.goodRateLabel.textColor = [UIColor whiteColor];
            self.badRateLabel.backgroundColor = [UIColor clearColor];
            self.badRateLabel.textColor = [UIColor redColor];
            self.midRateLabel.backgroundColor = [UIColor clearColor];
            self.midRateLabel.textColor = [GRAppStyle orangeColor];
        } else if (score > 3) {
            self.goodRateLabel.backgroundColor = [UIColor clearColor];
            self.goodRateLabel.textColor = [GRAppStyle mainColor];
            self.badRateLabel.backgroundColor = [UIColor clearColor];
            self.badRateLabel.textColor = [UIColor redColor];
            self.midRateLabel.backgroundColor = [GRAppStyle orangeColor];
            self.midRateLabel.textColor = [UIColor whiteColor];
        } else {
            self.goodRateLabel.backgroundColor = [UIColor clearColor];
            self.goodRateLabel.textColor = [GRAppStyle mainColor];
            self.badRateLabel.backgroundColor = [UIColor redColor];
            self.badRateLabel.textColor = [UIColor whiteColor];
            self.midRateLabel.backgroundColor = [UIColor clearColor];
            self.midRateLabel.textColor = [GRAppStyle orangeColor];
        }
    };
    
    [self.badRateLabel gr_addTapAction:^{
        [UIView gr_showOscillatoryAnimationWithLayer:self.badRateLabel.layer type:GROscillatoryAnimationToBigger range:1.3];
        self.starsView.score = 2.5;
    }];
    
    [self.goodRateLabel gr_addTapAction:^{
        [UIView gr_showOscillatoryAnimationWithLayer:self.goodRateLabel.layer type:GROscillatoryAnimationToBigger range:1.3];
        self.starsView.score = 5.0;
    }];
    
    [self.midRateLabel gr_addTapAction:^{
        [UIView gr_showOscillatoryAnimationWithLayer:self.midRateLabel.layer type:GROscillatoryAnimationToBigger range:1.3];
        self.starsView.score = 4.0;
    }];
    
    [self.shopLogo gr_addTapAction:^{
        [GRRouter open:@"push->GRMenuViewController" params:@{@"shop": _order.shop}];
    }];
}

#pragma - textField

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardBeginFrame = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    if (keyboardBeginFrame.size.height == 0) {
        return;
    }
   [UIView animateWithDuration:0.3 animations:^{
        self.view.gr_top = - self.textView.gr_top + 10 + 64;
   }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.view.gr_top = 0;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.submitBtn.enabled = YES;
    } else {
        self.submitBtn.enabled = NO;
    }
}

@end
