//
//  GRUserManager.h
//  GroooSource
//
//  Created by Assuner on 2017/2/14.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRUser.h"

@interface GRUserManager : NSObject

@property (nonatomic, strong) GRUser *currentUser;

+ (GRUserManager *)sharedManager;

+ (void)saveUserToDefaults;

+ (void)clearUserData;

@end
