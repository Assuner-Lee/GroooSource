//
//  GRLoginResponse.h
//  GroooSource
//
//  Created by 李永光 on 2017/2/10.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRModel.h"

@interface GRLoginData : GRModel

@property (nonatomic, assign) NSUInteger userID;

@property (nonatomic, strong) NSString *token;

@end


@interface GRLoginResponse : GRModel

@property (nonatomic, assign) NSUInteger code;

@property (nonatomic, strong) GRLoginData *loginData;

@property (nonatomic, strong) NSString *message;

@end
