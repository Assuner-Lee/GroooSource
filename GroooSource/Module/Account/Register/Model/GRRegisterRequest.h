//
//  GRRegisterRequest.h
//  GroooSource
//
//  Created by Assuner on 2017/2/13.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRNetRequestObject.h"

@interface GRRegisterRequest : GRNetRequestObject

- (instancetype)initWithMobile:(NSString *)mobile password:(NSString *)password;

@end
