//
//  SPHomePageMacro.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
  定义常量的文件夹
 */
@interface SPHomePageMacro : NSObject

 /** 商品主页 */
UIKIT_EXTERN NSString * const homeListFile ;

 /** 商品详情 */
UIKIT_EXTERN NSString * const productDetailDataURL;

 /** 请求下单 */
UIKIT_EXTERN NSString * const productAddOrderURL;

 /** 支付宝参数 */
UIKIT_EXTERN NSString * const productAliPayParam ;
/** 微信支付参数 */
UIKIT_EXTERN NSString * const productWeChatPayParam ;

/** 银联 */
UIKIT_EXTERN NSString * const productUnionpayParam;

/** 详情web url */
UIKIT_EXTERN NSString * const productDetailDespuRL ;

 /** 获得饮水量 */
UIKIT_EXTERN NSString * const WaterQuantity;

 /** 获得广告 与社区服务排行榜 */
UIKIT_EXTERN NSString * const HomePageData;

 /** 获得新闻列表 */
UIKIT_EXTERN NSString * const HomePageNewsList;

#pragma mark- 购物车相关
 /** 添加购物车 */
UIKIT_EXTERN NSString * const ShoppingCartAddCarURl;
 /** 商品信息 */
UIKIT_EXTERN NSString * const  ShoppingCartAttribute;
 /** 查询用户购物车所有商品 */
UIKIT_EXTERN NSString * const  ShoppingCartShowAllCars;
 /** 删除用户购物车商品 */
UIKIT_EXTERN NSString * const ShoppingCartDeleCarts;
 /** 更新用户购物车商品 */
UIKIT_EXTERN NSString * const  ShoppingCartUpdateCarts;
 /** 获取购物车数量 */
UIKIT_EXTERN NSString * const ShoppingCartFetchCarNum;


@end
