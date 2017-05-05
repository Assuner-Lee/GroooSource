//
//  GRUser.h
//  GroooSource
//
//  Created by Assuner on 2017/2/14.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRUserInfoData.h"
#import "GRLoginResponse.h"

@interface GRUser : NSObject

//********************* netData *******************

@property (nonatomic, strong) GRLoginData *loginData;

@property (nonatomic, strong) GRUserInfo *userInfo;

//********************* localData *******************

@property (nonatomic, strong) NSString *building;

@property (nonatomic, strong) NSString *address;


@end
