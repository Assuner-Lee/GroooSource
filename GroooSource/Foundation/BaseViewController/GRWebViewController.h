//
//  GRWebViewController.h
//  GroooSource
//
//  Created by 李永光 on 2017/2/9.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRViewController.h"

@interface GRWebViewController : GRViewController

- (instancetype)initWithURL:(NSString *)url title:(NSString *)text;

+ (UINavigationController *)modalWebviewWithURL:(NSString *)url title:(NSString *)text;

@end
