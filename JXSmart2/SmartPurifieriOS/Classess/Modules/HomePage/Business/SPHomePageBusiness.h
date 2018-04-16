//
//  SPHomePageBusiness.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseBusiness.h"

@interface SPHomePageBusiness : SPBaseBusiness



/**
 获取首页列表数据

 @param param 字典
 @param success 成功
 @param failere 失败
 */
-(void)getHomeFileListImage:(NSDictionary*)param success:(BusinessSuccessBlock)success failere:(BusinessFailureBlock)failere isGetCache:(BOOL)isCache;



/**
 获得商品详情数据

 @param param param
 @param success success
 @param failere 失败
 */
-(void)getProductDetailData:(NSDictionary*)param success:(BusinessSuccessBlock)success failere:(BusinessFailureBlock)failere;



/**
 请求商品下单

 @param param userid,adrid,proid,managerNo,settime,price
 @param success 成功
 @param failere 失败
 */
-(void)getProductAddOrder:(NSDictionary*)param
                 succcess:(BusinessSuccessBlock)success
                  failere:(BusinessFailureBlock)failere;


/**
 获得支付宝支付的请求参数

 @param param 参数uname,addr,price 价格,orderNo
 @param success 成功
 @param failere 失败
 */
-(void)getAliPayParamCode:(NSDictionary*)param
                 succcess:(BusinessSuccessBlock)success
                  failere:(BusinessFailureBlock)failere;


/**
 获得微信支付的请求参数

 @param param param
 @param success 成功
 @param failere 失败
 */
-(void)getWeChatPayParamCode:(NSDictionary*)param
                 succcess:(BusinessSuccessBlock)success
                  failere:(BusinessFailureBlock)failere;


/**
 获得银联支付的请求参数
 
 @param param param
 @param success 成功
 @param failere 失败
 */
-(void)getUnionPayParamCode:(NSDictionary*)param
                    succcess:(BusinessSuccessBlock)success
                     failere:(BusinessFailureBlock)failere;


/**
 获取饮水量数据

 @param param userid
 @param success 成功
 @param failere 失败
 */
-(void)getPurifierWaterData:(NSDictionary*)param
                   succcess:(BusinessSuccessBlock)success
                    failere:(BusinessFailureBlock)failere;


/**
 获取新闻列表

 @param param 参数
 @param success 成功
 @param failere 失败
 */
-(void)fetchHomePageNewsList:(NSDictionary*)param
                    succcess:(BusinessSuccessBlock)success
                     failere:(BusinessFailureBlock)failere;

/**
 获取首页数据
 
 @param param userid
 @param success 成功
 @param failere 失败
 */
-(void)getHomePageData:(NSDictionary*)param
                   succcess:(BusinessSuccessBlock)success
                    failere:(BusinessFailureBlock)failere;


#pragma mark - 添加购物车
-(void)insertShoppingCar:(NSDictionary*)param
                 success:(BusinessSuccessBlock)success
                 failere:(BusinessFailureBlock)failere;
#pragma mark - 商品信息
-(void)fetchShoppingCarProdesc:(NSDictionary*)param
                 success:(BusinessSuccessBlock)success
                 failere:(BusinessFailureBlock)failere;

#pragma mark - 获得购物车数量
-(void)fetchShoppingCarNum:(NSDictionary *)param
                   success:(BusinessSuccessBlock)success
                   failere:(BusinessFailureBlock)failere;


@end
