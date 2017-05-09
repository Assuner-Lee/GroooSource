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
#import "GRSettingViewController.h"
#import "GRFindMoreViewController.h"
#import "GRAddressViewController.h"

@interface GRUserInfoController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRatingLabel;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UILabel *addressStatusLabel;

@property (weak, nonatomic) IBOutlet UIView *findView;

@property (weak, nonatomic) IBOutlet UIView *settingView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *findViewTop;

@property (nonatomic, strong) GRUserInfo *userInfo;
@property (nonatomic, strong) GRUserInfoRequest *userInfoRequest;
@property (nonatomic, assign, getter=shouldUpdateNextAppeared) BOOL updateNextAppeared;

@end

@implementation GRUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.avatarImgView.layer.cornerRadius = self.avatarImgView.gr_width/2;
    self.avatarImgView.clipsToBounds = YES;
    self.findViewTop.constant = 16 - 2 - self.passwordView.gr_height;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearInfo) name:GRLogoutSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUpadateState) name:GRLoginSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAddressStatus) name:GRAddressSetSuccess object:nil];
}

- (void)setUserInfo:(GRUserInfo *)userInfo {
    _userInfo = userInfo;
    self.passwordView.hidden = NO;
    self.findViewTop.constant = 16;
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
    }
}

- (void)addGesture {
    [self.avatarImgView gr_addTapAction:^{
        
    }];
    
    [self.nickNameLabel gr_addTapAction:^{
        if (![GRUserManager sharedManager].currentUser.loginData.token) {
            [GRRouter open:@"present->GRLoginViewController" params:nil completed:nil];
        } else {
            [UIView gr_showOscillatoryAnimationWithLayer:self.nickNameLabel.layer type:GROscillatoryAnimationToSmaller range:0.7];
        }
    }];
    
    [self.userEmailLabel gr_addTapAction:^{
        [UIView gr_showOscillatoryAnimationWithLayer:self.userEmailLabel.layer type:GROscillatoryAnimationToBigger range:1.1];
    }];
    
    [self.addressView gr_addTapAction:^{
        if ([GRUserManager sharedManager].currentUser.loginData.token) {
            [self.navigationController pushViewController:[[GRAddressViewController alloc] init] animated:YES];
        } else {
            [GRRouter open:@"present->GRLoginViewController" params:nil completed:nil];
        }
    }];
    
    [self.passwordView gr_addTapAction:^{
        [self.navigationController pushViewController:[[GRChangePasswordController alloc] init] animated:YES];
    }];
    
    [self.findView gr_addTapAction:^{
        [self.navigationController pushViewController:[[GRFindMoreViewController alloc] init] animated:YES];
    }];
    
    [self.settingView gr_addTapAction:^{
        [self.navigationController pushViewController:[[GRSettingViewController alloc] init] animated:YES];
    }];
    
    [self.scoreLabel gr_addTapAction:^{
         [UIView gr_showOscillatoryAnimationWithLayer:self.scoreLabel.layer type:GROscillatoryAnimationToBigger range:1.5];
    }];
    
    [self.userRatingLabel gr_addTapAction:^{
        [UIView gr_showOscillatoryAnimationWithLayer:self.userRatingLabel.layer type:GROscillatoryAnimationToBigger range:1.5];
    }];
}

- (void)clearInfo {
    self.findViewTop.constant = 16 - 2 - self.passwordView.gr_height;
    self.passwordView.hidden = YES;
    self.avatarImgView.image = [UIImage imageNamed:@"user_avatar_placeholder"];
    self.nickNameLabel.text = @"点击登录";
    self.userEmailLabel.text = @"暂无数据";
    self.scoreLabel.text = @"***";
    self.userRatingLabel.text = @"***";
    self.addressStatusLabel.text = @"未登录";
    [self.userInfoRequest clearCache];
}

- (void)changeUpadateState {
    if (self.viewIfLoaded) {
        self.updateNextAppeared = YES;
    }
}

- (void)updateAddressStatus {
    self.addressStatusLabel.text = @"已设置";
}

@end
