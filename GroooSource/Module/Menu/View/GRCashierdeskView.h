//
//  GRCashierdeskView.h
//  GroooSource
//
//  Created by Assuner on 2017/4/1.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRMenuList.h"

@interface GRCashierdeskView : UIView

- (instancetype)initWithShopID:(NSUInteger)shopID basePrice:(NSUInteger)basePrice;
- (void)changeWithMenu:(GRMenu *)menu valueChange:(NSInteger)valueChange;

@end
