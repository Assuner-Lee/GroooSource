//
//  GRRatingOrderRequest.h
//  GroooSource
//
//  Created by Assuner on 2017/5/11.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRNetRequestObject.h"
#import "GROrderList.h"

@interface GRRatingOrderRequest : GRNetRequestObject

- (instancetype)initWithOrder:(GROrder *)order rating:(CGFloat)rating remark:(NSString *)remark;

@end
