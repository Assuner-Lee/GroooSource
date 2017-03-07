//
//  NSString+GRCommen.m
//  GroooSource
//
//  Created by 李永光 on 2017/2/8.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "NSString+GRCommen.h"

@implementation NSString (GRCommen)

+ (BOOL)gr_isInvalid:(NSString *)aString {
    return (aString == nil || ![aString isKindOfClass:[NSString class]] || [aString isEqualToString:@""] || [[aString gr_trimmed] isEqualToString:@""]);
}

- (NSString *)gr_trimmed{
    NSCharacterSet *whiteCharSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:whiteCharSet];
}

@end
