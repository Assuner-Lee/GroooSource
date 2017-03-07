//
//  GRShopListCell.h
//  GroooSource
//
//  Created by Assuner on 2017/2/22.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRShopList.h"

@interface GRShopListCell : UITableViewCell

@property (nonatomic, strong) GRShop *shopData;

@property (nonatomic, assign) NSUInteger *hight;

@end
