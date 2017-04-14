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

@interface GRCashierdeskCell : UITableViewCell

@property (nonatomic, copy) GRSelectedBlock selectBlock;
@property (nonatomic, copy) GRBlankBlock toZeroBlock;
@property (nonatomic, strong) GRMenu *menu;

@end
