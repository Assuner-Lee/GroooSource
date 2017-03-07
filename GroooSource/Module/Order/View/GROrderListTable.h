//
//  GROrderListTable.h
//  GroooSource
//
//  Created by Assuner on 2017/3/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GROrderList.h"

typedef NS_ENUM(NSUInteger, GROrderTableType) {
    GROrderTableTypeOnGoing = 0,
    GROrderTableTypeFinished = 1,
    GROrderTableTypeOther = 2,
};

@interface GROrderListTable : UITableView

@property (nonatomic, strong) NSArray<GROrder *> *cellDataArray;
@property (nonatomic, strong) NSString *title;

- (instancetype)initWithType:(GROrderTableType)type;

@end
