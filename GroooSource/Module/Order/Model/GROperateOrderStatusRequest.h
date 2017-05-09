//
//  GROperateOrderStatusRequest.h
//  GroooSource
//
//  Created by Assuner on 2017/5/9.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRNetRequestObject.h"
#import "GROrderStatusEnum.h"
#import "GROrderList.h"

@interface GROperateOrderStatusRequest : GRNetRequestObject

- (instancetype)initWithOrder:(GROrder *)order;

@end
