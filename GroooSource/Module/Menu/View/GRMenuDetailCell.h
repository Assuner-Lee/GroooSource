//
//  GRMenuDetailCell.h
//  GroooSource
//
//  Created by Assuner on 2017/3/29.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRMenuList.h"

typedef void (^GRSelectedBlock)(GRMenu *menu, NSInteger valueChange);

@interface GRMenuDetailCell : UITableViewCell

@property (nonatomic, copy) GRSelectedBlock selectBlock;

- (void)setMenu:(GRMenu *)menu shopStatus:(NSUInteger)shopStatus;

@end
