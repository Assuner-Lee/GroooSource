//
//  GRAPI.h
//  GroooSource
//
//  Created by 李永光 on 2017/2/6.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#ifndef GRAPI_h
#define GRAPI_h

//**************** API ****************


static NSString * const API_BASE_URL = @"http://api.grooo.cn/api/v3";
//********基础URL********


static NSString * const API_SCHOOL_LIST = @"/accounts/school";
//***服务学校列表***


static NSString * const API_USER_REGISTER = @"/accounts/";
//***用户注册***

static NSString * const API_DORM_LIST = @"/shops/building?school_id=1";
//***宿舍列表***

static NSString * const API_USER_LOGIN = @"/accounts/token";
//***用户登录***


static NSString * const API_SHOP_LIST = @"/shops/shop?school_id=1";
//***商家列表***

static NSString * const API_RATE_LIST = @"/shops/shop/%lu/rating";
//***商家评价列表***


static NSString * const API_MENU_LIST = @"/shops/shop/%lu/menu";
//***菜单列表***

static NSString * const API_PLACE_ORDER = @"/shops/shop/%lu/order";
//***下单操作***


static NSString * const API_USER_ORDER = @"/shops/user/order";
//***用户订单列表、评价订单***

static NSString * const API_ORDER_STATUS = @"/shops/shop/%lu/order";
//***修改订单状态***


//**************** URL ****************

static NSString * const kURL_FINDPASSWORD = @"http://www.grooo.cn/user/findPassword";


#endif /* GRAPI_h */
