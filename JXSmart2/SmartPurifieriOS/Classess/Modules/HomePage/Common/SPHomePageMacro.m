//
//  SPHomePageMacro.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPHomePageMacro.h"

@implementation SPHomePageMacro


NSString * const homeListFile = @"smvc/setup/mainImg.v";


NSString * const productDetailDataURL = @"smvc/setup/productdetail.v";

/** 请求下单 */
NSString * const productAddOrderURL = @"smvc/order/addorder.v";

/** 支付宝参数 */
NSString * const productAliPayParam  = @"smvc/pay/alipay.v";


NSString * const productWeChatPayParam =@"smvc/pay/wxpaysign.v";


/** 详情web url */
NSString * const productDetailDespuRL  = @"promise.jsp";

/** 银联 */
 NSString * const productUnionpayParam = @"smvc/pay/unionpay.v";

/** 获得饮水量 */
NSString * const WaterQuantity = @"smvc/setup/waterQuantity.v";

NSString * const HomePageData = @"smvc/setup/homepage.v";

/** 获得新闻列表 */
 NSString * const HomePageNewsList = @"smvc/news/information.v";

/** 添加购物车 */
 NSString* const ShoppingCartAddCarURl = @"smvc/shoppingcart/addshoppingcart.v";

/** 商品信息 */
 NSString*const  ShoppingCartAttribute = @"smvc/setup/attribute.v";
/** 查询用户购物车所有商品 */
 NSString*const  ShoppingCartShowAllCars = @"smvc/shoppingcart/showcat.v";
/** 删除用户购物车商品 */
 NSString* const ShoppingCartDeleCarts = @"smvc/shoppingcart/delcat.v";
/** 更新用户购物车商品 */
 NSString*const ShoppingCartUpdateCarts = @"smvc/shoppingcart/updatecat.v";

/** 获取购物车数量 */
 NSString * const ShoppingCartFetchCarNum = @"smvc/shoppingcart/selectnum.v";

@end
