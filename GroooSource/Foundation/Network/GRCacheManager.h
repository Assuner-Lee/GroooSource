//
//  GRCacheManager.h
//  GroooSource
//
//  Created by Assuner on 2017/2/24.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRModel.h"

@interface GRCacheManager : NSObject

+ (void)saveCacheWithObject:(GRModel *)model json:(NSDictionary *)dic forKey:(NSString *)path;

+ (id)modelCacheOfKey:(NSString *)path className:(NSString *)name;

+ (void)clearAllCache;

@end
