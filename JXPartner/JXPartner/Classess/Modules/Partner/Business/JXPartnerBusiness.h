//
//  JXPartnerBusiness.h
//  JXPartner
//
//  Created by windpc on 2017/8/14.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "SPBaseBusiness.h"

@interface JXPartnerBusiness : SPBaseBusiness


/**
 获取登录信息

 @param param
 @param successBlock
 @param failer
 */
-(void)fetchPartnerInformation:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer;


/**
 获取订单列表

 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)fetchPartnerOrderList:(NSDictionary*)param
                     success:(BusinessSuccessBlock)successBlock
                      failer:(BusinessFailureBlock)failer;

-(void)fetchHomePageNewsList:(NSDictionary*)param
                    succcess:(BusinessSuccessBlock)success
                     failere:(BusinessFailureBlock)failere;

/**
 获取订单详情

 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)fetchPartnerOrderDetail:(NSDictionary*)param
                     success:(BusinessSuccessBlock)successBlock
                      failer:(BusinessFailureBlock)failer;




/**
 获取我的下属

 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)fetchPartnerSublist:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer;


/**
 我的下属订单列表

 @param param
 @param successBlock
 @param failer
 */
-(void)fetchPartnerSubOrderlist:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer;



/**
 获取支付宝信息接口

 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)fetchBindingAliInformation:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer;


/**
 绑定支付宝

 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)bindingAliInformation:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer;


/**
 解绑支付宝信息

 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)unbundlingAliInformation:(NSDictionary*)param
             success:(BusinessSuccessBlock)successBlock
              failer:(BusinessFailureBlock)failer;



 /** 查找消息列表 */
-(void)fetchPartnerMessageList:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer;

 /** 删除消息 */
-(void)fetchPartnerMessageDelete:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer;
 /** 设置已读 */
-(void)fetchPartnerMessageSetReaded:(NSDictionary*)param
                         success:(BusinessSuccessBlock)successBlock
                          failer:(BusinessFailureBlock)failer;
 /** 统计未读数量 */
-(void)fetchPartnerMessageListCount:(NSDictionary*)param
                         success:(BusinessSuccessBlock)successBlock
                          failer:(BusinessFailureBlock)failer;


#pragma mark - 提现相关
 /** 提现记录 */
-(void)fetchTiXianHistory:(NSDictionary*)param
                  success:(BusinessSuccessBlock)successBlock
                   failer:(BusinessFailureBlock)failer;

 /** 提现发起 */
-(void)fetchTiXianRequestAdd:(NSDictionary*)param
                     success:(BusinessSuccessBlock)successBlock
                      failer:(BusinessFailureBlock)failer;
 /** 提现获取 */
-(void)fetchTiXianSalesAllMoney:(NSDictionary*)param
                        success:(BusinessSuccessBlock)successBlock
                         failer:(BusinessFailureBlock)failer;

 /** 提现项 */
-(void)fetchTiXianSaleItem:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer;

 /** 获取提现比例 */
-(void)fetchSubPermissions:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer;

 /** 更新提现比例 */
-(void)updateSubPermissions:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer;



/** 下级提现项 */
-(void)fetchSubTiXianSale:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer;

/** 上级审核下级体现单 */
-(void)updateSubTiXianState:(NSDictionary*)param
                  success:(BusinessSuccessBlock)successBlock
                   failer:(BusinessFailureBlock)failer;

#pragma mark - 售后模块
 /** 获得套餐寿命及滤芯寿命 */
-(void)fetchPlanFilterLifeList:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer;
 /** 搜索方法 */
-(void)fetchPlanFilterSearchKeyWorld:(NSDictionary*)param
                             success:(BusinessSuccessBlock)successBlock
                              failer:(BusinessFailureBlock)failer;

 /** 获取滤芯警告 */
-(void)fetchFilterWarningList:(NSDictionary*)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer;

/** 获取维修记录接口 */
-(void)fetchProductRepairList:(NSDictionary*)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer;

/** 查看当前任务列表 */
-(void)fetchAfterSalesList:(NSDictionary*)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer;

/** 查看任务详情 */
-(void)fetchAfterSalesDetails:(NSDictionary*)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer;

/** 查看评价数据详情 */
-(void)fetchAfterSalesPingJia:(NSDictionary*)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer;

@end
