//
//  GRLoginViewController.m
//  GroooSource
//
//  Created by 李永光 on 2017/2/10.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRLoginViewController.h"
#import "GRLoginResponse.h"
#import "GRLoginRequest.h"
#import "GRRegisterViewController.h"
#import "GRWebViewController.h"

@interface GRLoginViewController ()

@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorTipLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *findPasswordBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (nonatomic, strong) NSString *mobileText;
@property (nonatomic, strong) NSString *passwordText;

@end

@implementation GRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView {
    self.view.backgroundColor = [GRAppStyle mainPageImageColor];
    self.inputView.layer.cornerRadius = 4;
    self.loginBtn.layer.cornerRadius = 4;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.enabled = NO;
    self.errorTipLabel.hidden = YES;
    
    [self.loginBtn setBackgroundImage:[UIImage imageWithColor:[GRAppStyle colorWithRed:255 green:255 blue:255 alpha:0.7]] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [self.loginBtn setBackgroundImage:[UIImage imageWithColor:[GRAppStyle colorWithRed:255 green:255 blue:255 alpha:0.25]] forState:UIControlStateDisabled];
    
    [self.loginBtn setTitleColor:[GRAppStyle mainColorWithAlpha:0.7] forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[GRAppStyle mainColorWithAlpha:1.0] forState:UIControlStateHighlighted];
    [self.loginBtn setTitleColor:[GRAppStyle mainColorWithAlpha:0.5] forState:UIControlStateDisabled];
   
    [self.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.findPasswordBtn addTarget:self action:@selector(findPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.registerBtn addTarget:self action:@selector(goRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}

- (void)hideTipLabel {
    self.errorTipLabel.hidden = YES;
}

#pragma - override

- (void)setMobileText:(NSString *)mobileText {
    _mobileText = mobileText;
    self.mobileTextField.text = mobileText;
}

- (void)setPasswordText:(NSString *)passwordText {
    _passwordText = passwordText;
    self.passwordTextField.text = passwordText;
    self.loginBtn.enabled = YES;
}

#pragma - Actions

- (void)login {
    [self.view endEditing:YES];
    [self showProgress];
    GRWEAK(self);
    [[[GRLoginRequest alloc] initWithMobile:self.mobileTextField.text password:self.passwordTextField.text] startRequestComplete:^(GRLoginResponse * _Nullable responseObject, NSError * _Nullable error) {
        GRSTRONG(self);
        [self hideProgress];
        if (error) {
            self.errorTipLabel.hidden = NO;
            self.loginBtn.enabled = NO;
            [self performSelector:@selector(hideTipLabel) withObject:nil afterDelay:1.0];
            return;
        }
        [self showSuccess:@"登陆成功"];
        [GRUserManager sharedManager].currentUser.loginData = responseObject.loginData;
        [GRUserManager saveUserToDefaults];
        [[GRHTTPManager sharedManager].requestSerializer setValue:responseObject.loginData.token forHTTPHeaderField:@"Authorization"];
        [[NSNotificationCenter defaultCenter] postNotificationName:GRLoginSuccessNotification object:nil];
        [self back];
    }];
}

- (void)findPassword {
    [self presentViewController:[GRWebViewController modalWebviewWithURL:kURL_FINDPASSWORD title:@"找回密码"] animation:GRTransitionTypePageUnCurl completion:nil];
}

- (void)goRegister {
    [self presentViewController:[GRRegisterViewController alloc] animation:GRTransitionTypeRippleEffect completion:nil];
}

- (void)back {
    [self dismissViewControllerWithAnimation:GRTransitionTypeRippleEffect completion:nil];
}

#pragma - textField

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)textFieldTextDidChange:(NSNotification *)notification {
    if ([UITextFieldTextDidChangeNotification isEqualToString:notification.name] && ([self.mobileTextField isEqual:notification.object] || [self.passwordTextField isEqual:notification.object])) {
        if (self.mobileTextField.text.length >= 11) {
            self.mobileTextField.text = [self.mobileTextField.text substringToIndex:11];
        }
        if (self.mobileTextField.text.length >= 11 && self.passwordTextField.text.length > 0) {
            self.loginBtn.enabled = YES;
        } else {
            self.loginBtn.enabled = NO;
        }
    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardBeginFrame = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    if (keyboardBeginFrame.size.height == 0) {
        return;
    }
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardEndFrame = [self.view convertRect:keyboardEndFrame toView:self.view];
    CGFloat viewYoffset = self.loginBtn.gr_bottom - keyboardEndFrame.origin.y + 40;
    if (self.passwordTextField.isFirstResponder) {
        CGRect bounds = self.view.bounds;
        bounds.origin.y = viewYoffset;
        GRWEAK(self);
        [UIView animateWithDuration:0.25 animations:^{
            GRSTRONG(self);
            self.view.bounds = bounds;
        }];
    } else if (self.mobileTextField.isFirstResponder && self.view.bounds.origin.y != 0) {
        CGRect bounds = self.view.bounds;
        bounds.origin.y = 0;
        GRWEAK(self);
        [UIView animateWithDuration:0.25 animations:^{
            GRSTRONG(self);
            self.view.bounds = bounds;
        }];
    }
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if (self.view.bounds.origin.y != 0) {
        CGRect bounds = self.view.bounds;
        bounds.origin.y = 0;
        GRWEAK(self);
        [UIView animateWithDuration:0.25 animations:^{
            GRSTRONG(self);
            self.view.bounds = bounds;
        }];
    }
}

@end
