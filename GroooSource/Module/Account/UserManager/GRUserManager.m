//
//  GRUserManager.m
//  GroooSource
//
//  Created by Assuner on 2017/2/14.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRUserManager.h" 
#import "MJExtension.h"

@implementation GRUserManager

+ (GRUserManager *)sharedManager {
    static GRUserManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GRUserManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        NSDictionary *userDic = [NSDictionary dictionaryWithContentsOfFile:[GRUserManager filePath]];
        if (userDic) {
            self.currentUser = [GRUser mj_objectWithKeyValues:userDic];
        } else {
            self.currentUser = [[GRUser alloc] init];
        }
    }
    return self;
}

+ (NSString *)filePath {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"user.plist"];
}

+ (void)saveUserToDefaults {
    NSDictionary *userDic = [self sharedManager].currentUser.mj_keyValues;
    [userDic writeToFile:[self filePath] atomically:YES];
}

+ (void)clearUserData {
    [self sharedManager].currentUser = nil;
    NSDictionary *userDic = [[NSDictionary alloc] init];
    [userDic writeToFile:[self filePath] atomically:YES];
}

@end
