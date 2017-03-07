//
//  GRHTTPManager.h
//  GroooSource
//
//  Created by 李永光 on 2017/2/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "GRAPI.h"

typedef void (^GRRequestComplete)(id _Nullable responseObject, NSError * _Nullable error);

@interface GRHTTPManager : NSObject

+ (AFHTTPSessionManager *_Nonnull)sharedManager;

+ (void)GET:(NSString *_Nonnull)path completionHandler:(nullable GRRequestComplete)complete;

+ (void)POST:(NSString *_Nonnull)path paramsDic:(NSDictionary *_Nullable)paramsDic completionHandler:(nullable GRRequestComplete)complete;

+ (void)PUT:(NSString *_Nonnull)path paramsDic:(NSDictionary *_Nullable)paramsDic completionHandler:(nullable GRRequestComplete)complete;

@end

