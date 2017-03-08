//
//  GRAppStyle.m
//  GroooSource
//
//  Created by 李永光 on 2017/2/8.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRAppStyle.h"

@implementation GRAppStyle

#pragma - color

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [self colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)mainColor {
    return [self colorWithRed:43.5 green:198.5 blue:165.5];
}

+ (UIColor *)mainColorWithAlpha:(CGFloat)alpha {
    return [self colorWithRed:43.5 green:198.5 blue:165.5 alpha:alpha];
}

+ (UIColor *)mainPageImageColor {
    return [self colorWithRed:38 green:212 blue:181];
}

+ (UIColor *)transparentColor {
    return [self colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
}

+ (UIColor *)viewBaseColor {
    return [self colorWithRed:255.0 green:255.0 blue:250.0];
}

+ (UIColor *)maskingColor {
    return [self colorWithRed:0 green:0 blue:0 alpha:0.5];
}

+ (UIColor *)goldColor {
    return [self colorWithRed:244 green:214 blue:27];
}

+ (UIColor *)activityRedColor {
    return [self colorWithRed:240 green:116 blue:117];
}

+ (UIColor *)newGreenColor{
    return [self colorWithRed:114 green:188 blue:73];
}

+ (UIColor *)lineColor {
    return [[UIColor blackColor] colorWithAlphaComponent:0.12];
}

#pragma - font

+ (UIFont *)font12 {
    return [UIFont systemFontOfSize:12.0];
}

+ (UIFont *)font9 {
    return [UIFont systemFontOfSize:9.0];
}

+ (UIFont *)font13 {
    return [UIFont systemFontOfSize:13.0];
}

+ (UIFont *)font16 {
    return [UIFont systemFontOfSize:16.0];
}
#pragma - other

+ (NSDictionary *)attributeWithFont:(UIFont *)aFont color:(UIColor *)aColor {
    return @{NSFontAttributeName:aFont, NSForegroundColorAttributeName:aColor};
}

@end
