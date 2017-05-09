//
//  GRPicker.m
//  GroooSource
//
//  Created by Assuner on 2017/5/9.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRPicker.h"

@interface GRPicker () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *backsideView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *okLabel;
@property (nonatomic, strong) UILabel *cancelLabel;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray<NSString *> *pickerTitleArray;

@property (nonatomic, strong) UIColor *mainColor;

@property (nonatomic, copy) GRPickerSelectBlock selectBlock;

@property (nonatomic, strong) NSString *selectedText;

@end


@implementation GRPicker

- (instancetype)initWithTitleArray:(NSArray<NSString *> *)pickerTitleArray mainColor:(UIColor *)aColor selectedAction:(GRPickerSelectBlock)block {
    if (self = [super init]) {
        _pickerTitleArray = pickerTitleArray;
        _mainColor = aColor;
        _selectBlock = block;
        [self initView];
        [self addGesture];
    }
    return self;
}

- (void)initView {
    self.backsideView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.backsideView.backgroundColor = [UIColor blackColor];
    self.backsideView.alpha = 0;
    [MAIN_WINDOW addSubview:self.backsideView];
    
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 180)];
    self.mainView.backgroundColor = [UIColor whiteColor];
    [MAIN_WINDOW addSubview:self.mainView];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    self.headerView.backgroundColor = self.mainColor;
    [self.mainView addSubview:self.headerView];
    
    self.okLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    self.okLabel.textAlignment = NSTextAlignmentCenter;
    self.okLabel.text = @"确定";
    self.okLabel.textColor = [UIColor whiteColor];
    [self.headerView addSubview:self.okLabel];
    
    self.cancelLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headerView.gr_width - 50, 0, 50, 30)];
    self.cancelLabel.textAlignment = NSTextAlignmentCenter;
    self.cancelLabel.text = @"取消";
    self.cancelLabel.textColor = [UIColor whiteColor];
    [self.headerView addSubview:self.cancelLabel];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, self.mainView.gr_height - self.headerView.gr_height)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.mainView addSubview:self.pickerView];
}

- (void)addGesture {
    [self.okLabel gr_addTapAction:^{
        if (self.selectBlock) {
            self.selectBlock(self.selectedText);
        }
        [self hide];
    }];
    
    [self.backsideView gr_addTapAction:^{
        [self hide];
    }];
    
    [self.cancelLabel gr_addTapAction:^{
        [self hide];
    }];
}

- (void)selectRow:(NSUInteger)index {
    if (index < self.pickerTitleArray.count) {
         [self.pickerView selectRow:index inComponent:0 animated:YES];
    }
}

#pragma - Actions

- (void)show {
    [self.pickerView reloadAllComponents];
    [UIView animateWithDuration:0.3 animations:^{
        self.backsideView.alpha = 0.5;
        self.mainView.gr_bottom = SCREEN_HEIGHT;
    }];
}

- (void)hide {
    [self.pickerView reloadAllComponents];
    [UIView animateWithDuration:0.3 animations:^{
        self.backsideView.alpha = 0.0;
        self.mainView.gr_top = SCREEN_HEIGHT;
    }];
}

#pragma - UIPickerView 

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerTitleArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerTitleArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedText = self.pickerTitleArray[row];
}

@end
