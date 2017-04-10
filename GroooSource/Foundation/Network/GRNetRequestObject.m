//
//  GRNetRequestObject.m
//  GroooSource
//
//  Created by 李永光 on 2017/2/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRNetRequestObject.h"
#import "GRCacheManager.h"

@interface GRNetRequestObject ()

@property (nonatomic, copy) GRRequestComplete complete;

@end

@implementation GRNetRequestObject

- (instancetype)init {
    if (self = [super init]) {
        self.allowCache = YES;
    }
    return self;
}

- (NSDictionary *)paramsDic {
    return nil;
}

- (id)cache {
    return [GRCacheManager modelCacheOfKey:self.requestPath className:self.modelClassName];
}

- (void)startRequestComplete:(GRRequestComplete)complete {
    self.complete = complete;
    switch (self.httpMethod) {
        case GRHTTPMethodGet: {
            [GRHTTPManager GET:self.requestPath completionHandler:^(id  _Nullable responseObject, NSError * _Nullable error) {
                [self handleResponseObject:responseObject error:error];
            }];
        } break;
            
        case GRHTTPMethodPost: {
            [GRHTTPManager POST:self.requestPath paramsDic:[self paramsDic] completionHandler:^(id  _Nullable responseObject, NSError * _Nullable error) {
                [self handleResponseObject:responseObject error:error];
            }];
        } break;
            
        case GRHTTPMethodPut: {
            [GRHTTPManager PUT:self.requestPath paramsDic:[self paramsDic] completionHandler:^(id  _Nullable responseObject, NSError * _Nullable error) {
                [self handleResponseObject:responseObject error:error];
            }];
        } break;
            
        default:
            break;
    }
}

- (void)handleResponseObject:(id)responseObject error:(NSError *)error {
    if (!self.complete) {
        return;
    }
    
    if (error) {
        self.complete(nil, error);  
        return;
    }
    if (responseObject) {
        if (self.modelClassName) {
            Class modelClass = NSClassFromString(self.modelClassName);
            if (modelClass && [modelClass isSubclassOfClass:[GRModel class]]) {
               GRModel *object = [modelClass jsonToModel:responseObject];
               self.complete(object, nil);
               if (self.allowCache && self.httpMethod == GRHTTPMethodGet) {
                  [GRCacheManager saveCacheWithObject:object json:responseObject forKey:self.requestPath];
               }
            } else {
                [NSException raise:@"GRRequestError" format:@"class:(%@) doesn't exist or isn't subclass of GRModel", modelClass];
            }
        } else {
           self.complete(responseObject, nil);
        }
    }
}

@end
