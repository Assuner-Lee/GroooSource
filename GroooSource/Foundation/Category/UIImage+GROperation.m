//
//  UIImage+GROperation.m
//  GroooSource
//
//  Created by 李永光 on 2017/2/9.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "UIImage+GROperation.h"


@implementation UIImage (GROperation)

+ (UIImage *)imageWithColor:(UIColor *)aColor {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
