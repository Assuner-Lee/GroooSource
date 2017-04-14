//
//  GRShopRatingListRequest.h
//  GroooSource
//
//  Created by Assuner on 2017/3/30.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRNetRequestObject.h"

@interface GRShopRatingListRequest : GRNetRequestObject

@property (nonatomic, assign, readonly) NSUInteger shopID;

- (instancetype)initWithShopID:(NSUInteger)shopID;

@end
