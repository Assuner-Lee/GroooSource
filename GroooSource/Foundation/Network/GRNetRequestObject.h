//
//  GRNetRequestObject.h
//  GroooSource
//
//  Created by 李永光 on 2017/2/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRHTTPManager.h"

typedef NS_ENUM(NSUInteger, GRHTTPMethod) {
    GRHTTPMethodGet = 1,
    GRHTTPMethodPost,
    GRHTTPMethodPut,
};


@interface GRNetRequestObject : NSObject

@property (nonatomic, strong) NSString *requestPath;

@property (nonatomic, assign) GRHTTPMethod httpMethod;

@property (nonatomic, strong) NSString *modelClassName;

@property (nonatomic, strong) id cache;

@property (nonatomic, assign) BOOL allowCache;

- (void)startRequestComplete:(GRRequestComplete)complete;

- (NSDictionary *)paramsDic;

@end
