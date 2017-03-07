//
//  GRListTypeModel.h
//  GroooSource
//
//  Created by 李永光 on 2017/2/8.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRModel.h"

@interface GRListTypeModel : GRModel

@property (nonatomic, assign) NSUInteger code;    //HTTP状态码

@property (nonatomic, strong) NSArray *dataArray; //数据

@property (nonatomic, strong) NSString *message;  //提醒信息

@end
