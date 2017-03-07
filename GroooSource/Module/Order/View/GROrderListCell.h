//
//  GROrderListCell.h
//  GroooSource
//
//  Created by Assuner on 2017/3/6.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GROrderList.h"

@interface GROrderListCell : UITableViewCell

@property (nonatomic, strong) GROrder *orderData;
@property (nonatomic, assign) BOOL isSpread;

@end
