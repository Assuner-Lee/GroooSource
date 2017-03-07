//
//  GRHTTPManager.m
//  GroooSource
//
//  Created by 李永光 on 2017/2/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRHTTPManager.h"
#import "GRNotification.h"
#import "GRUserManager.h"

#pragma mark C-Method

NSString *getFullURL(NSString *path) {
    return [API_BASE_URL stringByAppendingString:path];
}

@implementation GRHTTPManager

+ (AFHTTPSessionManager *)sharedManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] init];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        responseSerializer.removesKeysWithNullValues = YES;
        manager.responseSerializer = responseSerializer;
        manager.requestSerializer.timeoutInterval = 20;
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        if ([GRUserManager sharedManager].currentUser.token) {
            [manager.requestSerializer setValue:[GRUserManager sharedManager].currentUser.token forHTTPHeaderField:@"Authorization"];
        }
    });
    return manager;
}

#pragma mark HTTPMethod

+ (void)GET:(NSString *_Nonnull)path completionHandler:(nullable GRRequestComplete)complete {
    [[self sharedManager] GET:getFullURL(path) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (complete) {
            complete(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self prehandleFailure:task];
        if (complete) {
            complete(nil, error);
        }
    }];
}

+ (void)POST:(NSString *_Nonnull)path paramsDic:(NSDictionary *_Nullable)paramsDic completionHandler:(nullable GRRequestComplete)complete {
    [[self sharedManager] POST:getFullURL(path) parameters:paramsDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (complete) {
            complete(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self prehandleFailure:task];
        if (complete) {
            complete(nil, error);
        }
    }];
}

+ (void)PUT:(NSString *_Nonnull)path paramsDic:(NSDictionary *_Nullable)paramsDic completionHandler:(nullable GRRequestComplete)complete {
    [[self sharedManager] PUT:getFullURL(path) parameters:paramsDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (complete) {
            complete(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self prehandleFailure:task];
        if (complete) {
            complete(nil, error);
        }
    }];
}

+ (void)prehandleFailure:(NSURLSessionDataTask *)task {
    if ([(NSHTTPURLResponse *)task.response statusCode] == 401) {
        [[NSNotificationCenter defaultCenter] postNotificationName:GRTokenInvaildNotification object:nil];
    }
}

@end


