//
//  GRUserInfoController.m
//  GroooSource
//
//  Created by Assuner on 2017/5/3.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRUserInfoController.h"
#import "GRUserInfoRequest.h"
#import "GRUserInfoData.h"
#import "GRChangePasswordController.h"

@interface GRUserInfoController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRatingLabel;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UILabel *addressStatusLabel;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIView *settingView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *settingViewTop;

@property (nonatomic, strong) GRUserInfo *userInfo;
@property (nonatomic, strong) GRUserInfoRequest *userInfoRequest;
@property (nonatomic, assign, getter=shouldUpdateNextAppeared) BOOL updateNextAppeared;

@end

@implementation GRUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.avatarImgView.layer.cornerRadius = self.avatarImgView.gr_width/2;
    self.avatarImgView.clipsToBounds = YES;
    self.settingViewTop.constant = 16 - 2 - self.passwordView.gr_height;
    self.passwordView.hidden = YES;
    if (self.userInfoRequest.cache) {
        self.userInfo = [self.userInfoRequest.cache userInfo];
    }
    [self startRequest];
    [self addGesture];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.shouldUpdateNextAppeared) {
        [self startRequest];
        self.updateNextAppeared = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)init {
    if (self = [super init]) {
         self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"bar_item_user"] tag:0];
         self.userInfoRequest = [[GRUserInfoRequest alloc] init];
    }
    return self;
}

- (void)setupBarItem {
    [super setupBarItem];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(startRequest)];
}

- (void)addObservedNotification {
    [super addObservedNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearInfo) name:GRTokenInvaildNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUpadateState) name:GRLoginSuccessNotification object:nil];
}

- (void)setUserInfo:(GRUserInfo *)userInfo {
    _userInfo = userInfo;
    self.passwordView.hidden = NO;
    self.settingViewTop.constant = 16;
    [self.avatarImgView setImageWithURL:[NSURL URLWithString:userInfo.avatar] placeholderImage:[UIImage imageNamed:@"user_avatar_placeholder"]];
    self.nickNameLabel.text = userInfo.nickName;
    if (userInfo.email) {
        self.userEmailLabel.text = userInfo.email;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", userInfo.score];
    self.userRatingLabel.text = @"100.0";
    if ([GRUserManager sharedManager].currentUser.address) {
        self.addressStatusLabel.text = @"已设置";
    } else {
        self.addressStatusLabel.text = @"未设置";
    }
}

- (void)startRequest {
    if ([GRUserManager sharedManager].currentUser.loginData.userID) {
        [self showProgress];
        self.userInfoRequest.requestPath = [NSString stringWithFormat:API_USER_INFO_F, [GRUserManager sharedManager].currentUser.loginData.userID];
        GRWEAK(self);
        [self.userInfoRequest startRequestComplete:^(GRUserInfoData *  _Nullable responseObject, NSError * _Nullable error) {
            GRSTRONG(self);
            [self hideProgress];
            if (error) {
                [self showFailure:@"加载失败!"];
                return;
            }
            self.userInfo = responseObject.userInfo;
        }];
    } else {
        [GRRouter open:@"present->GRLoginViewController" params:nil completed:^{[MBProgressHUD gr_showFailure:@"请先登录"];}];
    }
}

- (void)addGesture {
    UITapGestureRecognizer *avatarImgViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAvatarImgView)];
    self.avatarImgView.userInteractionEnabled = YES;
    [self.avatarImgView addGestureRecognizer:avatarImgViewTap];
    
    UITapGestureRecognizer *nickNameLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNickNameLabel)];
    self.nickNameLabel.userInteractionEnabled = YES;
    [self.nickNameLabel addGestureRecognizer:nickNameLabelTap];
    
    UITapGestureRecognizer *addressViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAddressView)];
    [self.addressView addGestureRecognizer:addressViewTap];
    
    UITapGestureRecognizer *passwordViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPasswordView)];
    [self.passwordView addGestureRecognizer:passwordViewTap];
    
    UITapGestureRecognizer *settingViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSettingView)];
    [self.settingView addGestureRecognizer:settingViewTap];
}

- (void)clearInfo {
    self.settingViewTop.constant = 16 - 2 - self.passwordView.gr_height;
    self.passwordView.hidden = YES;
    self.avatarImgView.image = [UIImage imageNamed:@"user_avatar_placeholder"];
    self.nickNameLabel.text = @"点击登录";
    self.userEmailLabel.text = @"暂无数据";
    self.scoreLabel.text = @"***";
    self.userRatingLabel.text = @"***";
    self.addressStatusLabel.text = @"未登录";
}

- (void)changeUpadateState {
    if (self.viewIfLoaded) {
        self.updateNextAppeared = YES;
    }
}

#pragma - Actions

- (void)tapAvatarImgView {
    
}

- (void)tapNickNameLabel {
    if (![GRUserManager sharedManager].currentUser.loginData.token) {
        [GRRouter open:@"present->GRLoginViewController" params:nil completed:nil];
    }
}

- (void)tapAddressView {
    
}

- (void)tapPasswordView {
    [self.navigationController pushViewController:[[GRChangePasswordController alloc] init] animated:YES];
}

- (void)tapSettingView {
    
}

@end
