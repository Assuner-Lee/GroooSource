//
//  GRChangePasswordRequest.h
//  GroooSource
//
//  Created by Assuner on 2017/5/6.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRNetRequestObject.h"

@interface GRChangePasswordRequest : GRNetRequestObject

- (instancetype)initWithNewPassWord:(NSString *)password;

@end
