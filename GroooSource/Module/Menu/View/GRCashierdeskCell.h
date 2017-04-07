//
//  GRCashierdeskCell.h
//  GroooSource
//
//  Created by Assuner on 2017/4/5.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRMenuList.h"

typedef void (^GRSelectedBlock)(GRMenu *menu, NSInteger valueChange);

typedef void (^GRTozeroBlock)(void);

@interface GRCashierdeskCell : UITableViewCell

@property (nonatomic, copy) GRSelectedBlock selectBlock;
@property (nonatomic, copy) GRTozeroBlock toZeroBlock;
@property (nonatomic, strong) GRMenu *menu;

@end
