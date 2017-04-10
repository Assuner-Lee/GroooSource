//
//  GRCashierdeskView.h
//  GroooSource
//
//  Created by Assuner on 2017/4/1.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRMenuList.h"
#import "GRShopList.h"
#import "GRCashierdeskCell.h"

@interface GRCashierdeskView : UIView

@property (nonatomic, copy) GRBlankBlock reloadBlock;

- (instancetype)initWithShop:(GRShop *)shop;
- (void)changeWithMenu:(GRMenu *)menu valueChange:(NSInteger)valueChange;
- (void)clear;

@end
