//
//  GRPicker.h
//  GroooSource
//
//  Created by Assuner on 2017/5/9.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  void (^GRPickerSelectBlock)(NSString *selectText);

@interface GRPicker : NSObject

- (void)show;
- (void)hide;
- (void)selectRow:(NSUInteger)index;
- (instancetype)initWithTitleArray:(NSArray<NSString *> *)pickerTitleArray mainColor:(UIColor *)aColor selectedAction:(GRPickerSelectBlock)block;

@end
