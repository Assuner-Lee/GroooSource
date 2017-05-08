//
//  GRTuhaoRankTableCell.h
//  GroooSource
//
//  Created by Assuner on 2017/5/8.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRUserInfoData.h"

@interface GRTuhaoRankTableCell : UITableViewCell

@property (nonatomic, strong) GRUserInfo *userInfo;

@property (nonatomic, assign) NSUInteger rankNumber;

@end
