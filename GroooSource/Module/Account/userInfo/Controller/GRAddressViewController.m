//
//  GRAddressViewController.m
//  GroooSource
//
//  Created by Assuner on 2017/5/9.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRAddressViewController.h"
#import "GRPicker.h"
#import "GRBuildingListRequest.h"
#import "GRListTypeModel.h"

@interface GRAddressViewController ()

@property (weak, nonatomic) IBOutlet UIView *buildingView;
@property (weak, nonatomic) IBOutlet UIView *roomView;
@property (weak, nonatomic) IBOutlet UILabel *buildingInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomInfoLabel;

@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *inputOKbtn;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UIImageView *pickerIcon;

@property (nonatomic, assign) BOOL isKeyBoardShow;

@property (weak, nonatomic) IBOutlet UIImageView *inputIcon;

@property (strong, nonatomic) GRPicker *picker;

@end

@implementation GRAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self startRequest];
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
    self.buildingInfoLabel.text = [GRUserManager sharedManager].currentUser.building;
    self.roomInfoLabel.text = [GRUserManager sharedManager].currentUser.address;
    
    self.inputView.backgroundColor = [GRAppStyle mainColor];
    
    self.okBtn.layer.cornerRadius = 4.0f;
    self.okBtn.clipsToBounds = YES;
    [self.okBtn setBackgroundImage:[UIImage imageWithColor:[GRAppStyle mainColorWithAlpha:1.0]] forState:UIControlStateNormal];
    [self.okBtn setBackgroundImage:[UIImage imageWithColor:[GRAppStyle mainColorWithAlpha:0.75]] forState:UIControlStateHighlighted];
    [self.okBtn addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
    
    self.textField.layer.cornerRadius = 4.0f;
    self.textField.clipsToBounds = YES;
    self.textField.text = self.roomInfoLabel.text;
}

- (void)startRequest {
    [self showProgress];
    [[[GRBuildingListRequest alloc] init] startRequestComplete:^(GRListTypeModel *  _Nullable responseObject, NSError * _Nullable error) {
        [self hideProgress];
        if (error) {
            [self showFailure:@"获取楼栋地址失败，请稍后重试"];
            return;
        }
        GRWEAK(self);
        self.picker = [[GRPicker alloc] initWithTitleArray:responseObject.dataArray mainColor:[GRAppStyle mainColor] selectedAction:^(NSString *selectText) {
            GRSTRONG(self);
            self.buildingInfoLabel.text = selectText;
        }];
        if ([responseObject.dataArray containsObject:self.buildingInfoLabel.text]) {
            [self.picker selectRow:[responseObject.dataArray indexOfObject:self.buildingInfoLabel.text]];
        }
    }];
}

- (void)addObservedNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)addGesture {
    [self.buildingView gr_addTapAction:^{
        [self.view endEditing:YES];
        [UIView gr_showOscillatoryAnimationWithLayer:self.pickerIcon.layer type:GROscillatoryAnimationToBigger range:1.5];
        [self.picker show];
    }];
    
    [self.roomView gr_addTapAction:^{
        if (!self.isKeyBoardShow) {
             [UIView gr_showOscillatoryAnimationWithLayer:self.inputIcon.layer type:GROscillatoryAnimationToBigger range:1.5];
             [self.textField becomeFirstResponder];
        }
    }];
    
    [self.inputOKbtn gr_addTapAction:^{
        self.roomInfoLabel.text = self.textField.text;
        [self.textField resignFirstResponder];
    }];
    
    [self.view gr_addTapAction:^{
        [self.view endEditing:YES];
    }];
}

#pragma - textField

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardBeginFrame = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    if (keyboardBeginFrame.size.height == 0) {
        return;
    }
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardEndFrame = [self.view convertRect:keyboardEndFrame toView:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        self.inputView.gr_bottom = self.view.gr_height - keyboardEndFrame.size.height;
        self.isKeyBoardShow = YES;
    }];
    
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.isKeyBoardShow = NO;
}

#pragma - Actions

- (void)ok {
    if (!self.buildingInfoLabel.text.length && !self.roomInfoLabel.text.length) {
        [self showMessage:@"请选择楼栋和填写详细地址!"];
        return;
    }
    if (!self.buildingInfoLabel.text.length) {
        [self showMessage:@"请选择楼栋!"];
        return;
    }
    if (!self.roomInfoLabel.text.length) {
        [self showMessage:@"请填写详细地址!"];
        return;
    }
    
    [GRUserManager sharedManager].currentUser.building = self.buildingInfoLabel.text;
    [GRUserManager sharedManager].currentUser.address = self.roomInfoLabel.text;
    [GRUserManager saveUserToDefaults];
    [[NSNotificationCenter defaultCenter] postNotificationName:GRAddressSetSuccess object:nil];
    [MBProgressHUD gr_showSuccess:@"保存成功!"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
