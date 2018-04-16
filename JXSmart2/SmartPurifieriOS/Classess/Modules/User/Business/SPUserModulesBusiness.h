//
//  SPUserModulesBusiness.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseBusiness.h"

@interface SPUserModulesBusiness : SPBaseBusiness
@property (nonatomic,retain) NSString *userType;


//上传头像
-(void)uploadUserICO:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer;
/**
 个人 - 我的净水器列表

 @param param phoneNum<Y>,
 @param successBlock 净水器模型数组
 @param failer 提示语
 */
-(void)getUserPurifierList:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer;

/**
 个人 - 我的净水器详情
 
 @param param phoneNum<Y>,pro_id<Y>
 @param successBlock 净水器数据
 @param failer 提示语
 */
-(void)getUserPurifierDetail:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer;


//我的订单
-(void)getUserMyOrder:(NSDictionary*)param
                     success:(BusinessSuccessBlock)successBlock
                      failer:(BusinessFailureBlock)failer;

//我的订单详情
-(void)getUserMyOrderDetail:(NSDictionary*)param
              success:(BusinessSuccessBlock)successBlock
               failer:(BusinessFailureBlock)failer;


//个人信息
-(void)getUserInfo:(NSDictionary*)param
              success:(BusinessSuccessBlock)successBlock
               failer:(BusinessFailureBlock)failer;


/**
 获得用户家庭地址接口

 @param param id为地址id,为空表示新增,非空表示修改,userid:用户ID,name:收货人姓名,phone:收货人手机号,area:区域,detail:街道门牌,code:邮政编码,isdefault=0表示默认地址
 @param successBlock
 @param failer
 */
-(void)getUserHomeList:(NSDictionary*)param
               success:(BusinessSuccessBlock)successBlock
                failer:(BusinessFailureBlock)failer;


/**
 新增或者修改地址

 @param param id为地址id,为空表示新增,非空表示修改,userid:用户ID,name:收货人姓名,phone:收货人手机号,area:区域,detail:街道门牌,code:邮政编码,isdefault=0表示默认地址
 @param successBlock 成功
 @param failer 失败
 */
-(void)getModifyHomeAddress:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer;

/**
 删除某条地址

 @param param 地址id
 @param successBlock 成功
 @param failer 失败
 */
-(void)getDeleteHomeAddress:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer;


//商家发布
-(void)getMerchantRelease:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer;

//订单删除
-(void)getUserOrderDel:(NSDictionary*)param
                  success:(BusinessSuccessBlock)successBlock
                   failer:(BusinessFailureBlock)failer;


//分享绑定
-(void)getSharePhoneNum:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer;

//更改手机号
-(void)getModifyPhoneNum:(NSDictionary *)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer;


/**
 获取消息列表

 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)getMessageList:(NSDictionary *)param
              success:(BusinessSuccessBlock)successBlock
               failer:(BusinessFailureBlock)failer;


/**
 获得余量查询

 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)getClarifierDetailCost:(NSDictionary *)param
              success:(BusinessSuccessBlock)successBlock
               failer:(BusinessFailureBlock)failer;

/**
 获得续费下单
 
 @param param 参数    ord_no,paytype,price,proname
 @param successBlock 成功
 @param failer 失败
 */
-(void)getClarifierAddOrderCost:(NSDictionary *)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer;



/**
 更改某条消息为已读

 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)getChangeMessageWithRead:(NSDictionary *)param
                        success:(BusinessSuccessBlock)successBlock
                         failer:(BusinessFailureBlock)failer;

/**
 删除某条消息

 @param param 消息id
 @param successBlock chengg
 @param failer dhib
 */
-(void)getDeleteOneOfMessage:(NSDictionary *)param
                        success:(BusinessSuccessBlock)successBlock
                         failer:(BusinessFailureBlock)failer;


/**
 获得未读消息数

 @param param userid
 @param successBlock chengg
 @param failer shib
 */
-(void)getNotReadMessageCount:(NSDictionary *)param
                     success:(BusinessSuccessBlock)successBlock
                      failer:(BusinessFailureBlock)failer;


/**
 获取续费订单详情

 @param param
 @param successBlock
 @param failer
 */
-(void)getUserOrderRenewalDetail:(NSDictionary *)param
                        success:(BusinessSuccessBlock)successBlock
                         failer:(BusinessFailureBlock)failer;



//社会化分享
-(void)getUserShare:(NSDictionary *)param
                         success:(BusinessSuccessBlock)successBlock
                          failer:(BusinessFailureBlock)failer;


#pragma mark - 购物车

/**
 查询用户购物车所有商品

 @param param
 @param successBlock
 @param failer
 */
-(void)fetchMyShoppingCarAllList:(NSDictionary *)param
                         success:(BusinessSuccessBlock)successBlock
                          failer:(BusinessFailureBlock)failer;


/**
 删除用户购物车商品

 @param param
 @param successBlock
 @param failer
 */
-(void)deleteMyShoppingCar:(NSDictionary *)param
                         success:(BusinessSuccessBlock)successBlock
                          failer:(BusinessFailureBlock)failer;


/**
 更新用户购物车商品

 @param param
 @param successBlock
 @param failer
 */
-(void)updateMyShoppingCar:(NSDictionary *)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer;


/**
 获取我的推广

 @param param userid
 @param successBlock
 @param failer
 */
-(void)fetchMyPromoter:(NSDictionary *)param
               success:(BusinessSuccessBlock)successBlock
                failer:(BusinessFailureBlock)failer;

#pragma mark - 售后模块
-(void)fetch_AfterSalesList:(NSDictionary *)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer;

//获取购买设备列表
-(void)fetch_productList:(NSDictionary *)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer;

//获取设备对应的滤芯
-(void)fetch_trafficList:(NSDictionary *)param
                 success:(BusinessSuccessBlock)successBlock
                  failer:(BusinessFailureBlock)failer;
//获取故障现象
-(void)fetch_faultErrTipList:(NSDictionary *)param
                     success:(BusinessSuccessBlock)successBlock
                      failer:(BusinessFailureBlock)failer;

//发布一个新的
-(void)fetch_updateNewAfterSales:(NSDictionary *)param
                          images:(NSMutableArray*)images
                         success:(BusinessSuccessBlock)successBlock
                          failer:(BusinessFailureBlock)failer;

//查看详情数据
-(void)fetch_AfterSalesDetails:(NSDictionary *)param
                         success:(BusinessSuccessBlock)successBlock
                          failer:(BusinessFailureBlock)failer;

//新增评价
-(void)fetch_InsertPingJiaData:(NSDictionary *)param
                        images:(NSMutableArray*)images
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer;
//查看评价
-(void)fetch_getPingJiaDetail:(NSDictionary *)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer;
@end
