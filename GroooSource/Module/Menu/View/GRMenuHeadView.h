//
//  GRMenuHeadView.h
//  GroooSource
//
//  Created by Assuner on 2017/3/23.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRShopList.h"

@interface GRMenuHeadView : UIView

@property (nonatomic, copy) GRBlankBlock backBlock;

- (instancetype)initWithShop:(GRShop *)shop;
- (void)changeWithOffsetY:(CGFloat)y;

@end
