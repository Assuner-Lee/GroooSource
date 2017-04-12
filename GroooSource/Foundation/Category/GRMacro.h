//
//  GRMacro.h
//  GroooSource
//
//  Created by Assuner on 2017/2/14.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#ifndef GRMacro_h
#define GRMacro_h

//**************** macro ****************

#define GRWEAK(aObject) \
__weak typeof(aObject) weak##aObject = aObject

#define GRSTRONG(aObject) \
__strong typeof(weak##aObject) aObject = weak##aObject

#define MAIN_WINDOW  [UIApplication sharedApplication].delegate.window
#define ROOT_VC      ((GRTabBarViewController *)(MAIN_WINDOW.rootViewController))
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define ADAPTX_VALUE(w) (w*[UIScreen mainScreen].bounds.size.width / 375)
#define ADAPTY_VALUE(h) (h*[UIScreen mainScreen].bounds.size.height / 667)

#define SIZE_OF_TEXT(text, size, font)     \
[text boundingRectWithSize:size            \
                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  \
                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}    \
                   context:nil]

#define MIN_SIZE(label) label.attributedText.size

#endif /* GRMacro_h */
