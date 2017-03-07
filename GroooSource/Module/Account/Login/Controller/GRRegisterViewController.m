//
//  GRRegisterViewController.m
//  GroooSource
//
//  Created by Assuner on 2017/2/12.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRRegisterViewController.h"
#import "GRRegisterRequest.h"

@interface GRRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorTipLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation GRRegisterViewController

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
    self.registerBtn.layer.cornerRadius = 4;
    self.registerBtn.layer.masksToBounds = YES;
    self.registerBtn.enabled = NO;
    self.errorTipLabel.hidden = YES;
    
    [self.registerBtn setBackgroundImage:[UIImage imageWithColor:[GRAppStyle colorWithRed:255 green:255 blue:255 alpha:0.7]] forState:UIControlStateNormal];
    [self.registerBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [self.registerBtn setBackgroundImage:[UIImage imageWithColor:[GRAppStyle colorWithRed:255 green:255 blue:255 alpha:0.25]] forState:UIControlStateDisabled];
    
    [self.registerBtn setTitleColor:[GRAppStyle mainColorWithAlpha:0.7] forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[GRAppStyle mainColorWithAlpha:1] forState:UIControlStateHighlighted];
    [self.registerBtn setTitleColor:[GRAppStyle mainColorWithAlpha:0.5] forState:UIControlStateDisabled];
    
    [self.registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)hideTipLabel {
    self.errorTipLabel.hidden = YES;
}

#pragma - Actions

- (void)registerAction {
    [self.view endEditing:YES];
    [self showProgress];
    GRWEAK(self);
    [[[GRRegisterRequest alloc] initWithMobile:self.mobileTextField.text password:self.passwordTextField.text] startRequestComplete:^(id  _Nullable responseObject, NSError * _Nullable error) {
        GRSTRONG(self);
        [self hideProgress];
        if (error) {
            self.errorTipLabel.hidden = NO;
            self.registerBtn.enabled = NO;
            [self performSelector:@selector(hideTipLabel) withObject:nil afterDelay:1.0];
            return;
        }
        [self.presentingViewController setValue:self.mobileTextField.text forKey:@"mobileText"];
        [self.presentingViewController setValue:self.passwordTextField.text forKey:@"passwordText"];
        [self back];
        
    }];
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
            self.registerBtn.enabled = YES;
        } else {
            self.registerBtn.enabled = NO;
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
    CGFloat viewYoffset = self.registerBtn.gr_bottom - keyboardEndFrame.origin.y + 20;
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
