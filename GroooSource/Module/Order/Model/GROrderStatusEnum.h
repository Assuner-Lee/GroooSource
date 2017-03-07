//
//  GROrderStatusEnum.h
//  GroooSource
//
//  Created by Assuner on 2017/3/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#ifndef GROrderStatusEnum_h
#define GROrderStatusEnum_h

typedef NS_ENUM(NSUInteger, GROrderStatus) {
    GROrderStatusNotTaked = 0,
    GROrderStatusTaked = 10,
    GROrderStatusCanceling = 20,
    GROrderStatusCanceled = 21,
    GROrderStatusRefused = 22,
    GROrderStatusDone = 30,
    GROrderStatusRated = 31,
};

#endif /* GROrderStatusEnum_h */
