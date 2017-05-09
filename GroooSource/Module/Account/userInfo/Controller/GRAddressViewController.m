//
//  GRAddressViewController.m
//  GroooSource
//
//  Created by Assuner on 2017/5/9.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRAddressViewController.h"

@interface GRAddressViewController ()

@property (weak, nonatomic) IBOutlet UIView *buildingView;
@property (weak, nonatomic) IBOutlet UIView *roomView;
@property (weak, nonatomic) IBOutlet UILabel *buildingInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomInfoLabel;

@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *inputOKbtn;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@end

@implementation GRAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self addGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"收货地址";
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)initView {
    self.okBtn.layer.cornerRadius = 4.0f;
    self.okBtn.clipsToBounds = YES;
    
    
    self.textField.layer.cornerRadius = 4.0f;
    self.textField.clipsToBounds = YES;
    
    self.textField.text = self.roomInfoLabel.text;
    
}

- (void)addObservedNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)addGesture {
    [self.roomView gr_addTapAction:^{
        [self.textField becomeFirstResponder];
    }];
    
    [self.inputOKbtn gr_addTapAction:^{
        [self.textField resignFirstResponder];
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
    
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardEndFrame = [self.view convertRect:keyboardEndFrame toView:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        self.inputView.gr_bottom = self.view.gr_height - keyboardEndFrame.size.height;
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.roomInfoLabel.text = self.textField.text;
}


@end
