//
//  GRMenuMainView.h
//  GroooSource
//
//  Created by Assuner on 2017/3/24.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRMenuList.h"
#import "GRMenuDetailCell.h"

@interface GRMenuMainView : UIView

@property (nonatomic, strong) NSArray<GRMenu *> *menuDataArray;
@property (nonatomic, copy) GRSelectedBlock selectBlock;

- (instancetype)initWithShopStatus:(NSUInteger)shopStatus;
- (void)reload;

@end

