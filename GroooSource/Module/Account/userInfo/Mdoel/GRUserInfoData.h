//
//  GRUserInfoData.h
//  GroooSource
//
//  Created by Assuner on 2017/5/5.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRModel.h"

@interface GRUserInfo : GRModel

@property (nonatomic, assign) NSUInteger userID;

@property (nonatomic, strong) NSString *nickName;

@property (nonatomic, strong) NSString *avatar;

@property (nonatomic, strong) NSString *email;

//@property (nonatomic, strong) NSString *schoolName;

@property (nonatomic, assign) double score;

@end


@interface GRUserInfoData : GRModel

@property (nonatomic, assign) NSUInteger code;    //HTTP状态码

@property (nonatomic, strong) GRUserInfo *userInfo; //用户数据

@property (nonatomic, strong) NSString *message;  //提醒信息


@end
