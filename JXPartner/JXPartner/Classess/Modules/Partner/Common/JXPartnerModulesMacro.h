//
//  JXPartnerModulesMacro.h
//  JXPartner
//
//  Created by windpc on 2017/8/16.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXPartnerModulesMacro : NSObject

//获取信息
UIKIT_EXTERN NSString * const URL_FetchPartnerInformation;

//订单列表
UIKIT_EXTERN NSString * const  URL_FETCHPARTNERORDERLIST;

//订单详情
UIKIT_EXTERN NSString * const  URL_FETCHPARTNERORDERDETAIL;

//我的下属
UIKIT_EXTERN NSString * const URL_FETCHPARNERSUBLIST;
//我的下属订单列表
UIKIT_EXTERN NSString * const URL_FetchParnerSubOrderList;

//绑定支付宝
UIKIT_EXTERN NSString * const URL_BindingAliAct;
//解绑支付宝
UIKIT_EXTERN NSString * const URL_UnBoodingAliAct ;
//查看支付宝
UIKIT_EXTERN NSString * const URL_FetchAliInfo;

//查看消息列表
UIKIT_EXTERN NSString * const URL_FetchPartnerMessageList;
//删除消息
UIKIT_EXTERN NSString * const URL_FetchPartnerMessageDelete;
//修改状态为已读
UIKIT_EXTERN NSString * const URL_FetchPartnerMessageSetReaded;
//统计数量
UIKIT_EXTERN NSString * const URL_FetchPartnerMessageListCount;

//提现相关
UIKIT_EXTERN NSString * const URL_FetchTiXianMoney;
//提现记录
UIKIT_EXTERN NSString * const URL_FetchTiXianHistory;
//提现发起
UIKIT_EXTERN NSString * const URL_FetchTiXianRequestAdd;
//提现项
UIKIT_EXTERN NSString * const URL_FetchTiXianItem;

//查看比例分别接口
UIKIT_EXTERN NSString * const URL_FetchParnerPermissions;

//修改下属比例接口
UIKIT_EXTERN NSString * const URL_UpdatePartnerPermissions;

//下级提现项
UIKIT_EXTERN NSString * const URL_FetchSubTiXianDetail;

/** 上级审核下级体现单 */
UIKIT_EXTERN NSString * const URL_UpdateSubTiXianState;

UIKIT_EXTERN NSString * const HomePageNewsList ;


+(NSString*)fetchParnerLevelString:(NSInteger)level;

+(NSInteger)fetchParnerLevelInter:(NSString*)level;

+(NSString*)fetchWithDrawal_State:(NSInteger)state;

#pragma mark - 售后模块
//套餐情况及滤芯情况统计
UIKIT_EXTERN NSString * const URL_FetchPlanFilterLifeList;
//搜索接口
UIKIT_EXTERN NSString * const URL_FetchPlanFilterSearchKeyWorld ;
//滤芯警告接口
UIKIT_EXTERN NSString * const URL_FetchFilterWarningList;
//维修记录接口
UIKIT_EXTERN NSString * const URL_FetchProductRepairList;
//查看当前售后任务
UIKIT_EXTERN NSString * const URL_FetchAfterSalesList ;
//查看某个详情
UIKIT_EXTERN NSString * const URL_FetchAfterSalesDetails ;
//合伙人查看评价
UIKIT_EXTERN NSString * const URL_FetchAfterSalesPingJiaData;

+(NSString*)fetchProductDescWithType:(NSInteger)type;

@end
