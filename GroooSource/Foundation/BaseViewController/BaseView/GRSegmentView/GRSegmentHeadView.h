//
//  GRSegmentHeadView.h
//  GroooSource
//
//  Created by Assuner on 2017/3/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GRSegmentHeadViewDelegate <NSObject>

@optional
- (void)changeWithTapIndex:(NSUInteger)index;

@end


@interface GRSegmentHeadView : UIView

@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@property (nonatomic, strong) UIView *slideLine;

@property (nonatomic, weak) id <GRSegmentHeadViewDelegate> delegate;

@end
