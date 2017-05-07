//
//  GRChangePasswordController.m
//  GroooSource
//
//  Created by Assuner on 2017/5/6.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRChangePasswordController.h"
#import "GRChangePasswordRequest.h"

@interface GRChangePasswordController ()

@property (weak, nonatomic) IBOutlet UITextField *firstInputField;
@property (weak, nonatomic) IBOutlet UITextField *secondInputField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *errorTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstTitleLabel;

@end

@implementation GRChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.submitButton.layer.cornerRadius = 4.0f;
    self.submitButton.clipsToBounds = YES;
    [self.submitButton setBackgroundImage:[UIImage imageWithColor:[GRAppStyle mainColorWithAlpha:0.4]] forState:UIControlStateDisabled];
    [self.submitButton setBackgroundImage:[UIImage imageWithColor:[GRAppStyle mainColorWithAlpha:1]] forState:UIControlStateNormal];
    [self.submitButton setBackgroundImage:[UIImage imageWithColor:[GRAppStyle mainColorWithAlpha:0.75]] forState:UIControlStateHighlighted];
    self.submitButton.enabled = NO;
    [self.submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    [self.firstInputField becomeFirstResponder];
    self.errorTipLabel.hidden = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView gr_showOscillatoryAnimationWithLayer:self.firstTitleLabel.layer type:GROscillatoryAnimationToBigger range:1.3];
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"修改密码";
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)addObservedNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}



#pragma - textField

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)textFieldTextDidChange:(NSNotification *)notification {
    if (self.firstInputField.text.length && self.secondInputField.text.length) {
        self.submitButton.enabled = YES;
    } else {
        self.submitButton.enabled = NO;
    }
}

- (void)hideErrorTipLabel {
    self.errorTipLabel.hidden = YES;
}

#pragma - Actions 

- (void)submit {
    self.submitButton.enabled = NO;
    if (![self.firstInputField.text isEqualToString:self.secondInputField.text]) {
        self.errorTipLabel.hidden = NO;
        self.submitButton.enabled = YES;
        [self performSelector:@selector(hideErrorTipLabel) withObject:nil afterDelay:1.0f];
    } else {
        [self showProgress];
        GRWEAK(self);
        [[[GRChangePasswordRequest alloc] initWithNewPassWord:self.firstInputField.text] startRequestComplete:^(id  _Nullable responseObject, NSError * _Nullable error) {
            GRSTRONG(self);
            [self hideProgress];
            if (error) {
                self.submitButton.enabled = YES;
                return;
            }
            [MBProgressHUD gr_showSuccess:@"修改成功,请重新登录!"];
            [GRUserManager clearUserData];
            [[NSNotificationCenter defaultCenter] postNotificationName:GRLogoutSuccessNotification object:nil];
            [self back];
        }];
    }
}

@end
