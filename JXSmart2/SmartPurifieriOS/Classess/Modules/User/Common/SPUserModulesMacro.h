//
//  SPUserModulesMacro.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
  定义常量的文件夹
 */
@interface SPUserModulesMacro : NSObject

/**  修改头像 */
UIKIT_EXTERN NSString * const userChangeHeadIcoURL ;

 /** 用户-我的净水机列表 */
UIKIT_EXTERN NSString * const userPurifierList ;

 /** 访问净水器滤芯状态 */
UIKIT_EXTERN NSString * const userPurifierDetail ;

/** 我的订单 */
UIKIT_EXTERN NSString * const userMyOrder;

/** 我的订单 */
UIKIT_EXTERN NSString * const userMyOrderDetail;

/** 我的昵称 */
UIKIT_EXTERN NSString * const userNickName;

/** 我的性别 */
UIKIT_EXTERN NSString * const userSex;

/** 我的签名 */
UIKIT_EXTERN NSString * const userSign;

/** 我的地址 */
UIKIT_EXTERN NSString * const userHomeAddressList;

 /** 新增、修改地址 */
UIKIT_EXTERN NSString * const userHomeAddressModify;

/** 意见反馈 */
UIKIT_EXTERN NSString * const userOption;

/** 删除地址 */
UIKIT_EXTERN NSString * const userHomeAddressDelete;

/** 商家发布 */
UIKIT_EXTERN NSString * const userMerchantRelease;

/** 订单删除 */
UIKIT_EXTERN NSString * const userOrderDel;

/** 分享绑定 */
UIKIT_EXTERN NSString * const userSharePhoneNum;

 /** 获取消息列表 */
UIKIT_EXTERN NSString * const userMessageList ;

 /** 余量查询 */
UIKIT_EXTERN NSString * const userClarifierDetailCost;

 /** 续费订单接口 */
UIKIT_EXTERN NSString * const UserClarifierCostPay;

/** 更改手机号 */
UIKIT_EXTERN NSString * const userModifyPhoneNum ;

 /** 更改某条消息为已读 */
UIKIT_EXTERN NSString * const userChangeMessageWithRead;

/** 删除消息 */
UIKIT_EXTERN NSString * const userDeleteMessage;

/** 消息未读数 */
UIKIT_EXTERN NSString * const userNotReadMessageCount;

 /** 订单续费详情 */
UIKIT_EXTERN NSString * const userOrderRenewalDetail;

/** 社会化分享 */
UIKIT_EXTERN NSString * const userhShareURL;

//我的推广
UIKIT_EXTERN NSString * const userAllPromoter;

#pragma mark - 售后模块
//售后列表
UIKIT_EXTERN NSString * const fetch_user_afterLists;
//选择设备
UIKIT_EXTERN NSString * const fetch_chooseProductlist;
//选择滤芯
UIKIT_EXTERN NSString * const fetch_chooseTrafficlist;
//故障列表
UIKIT_EXTERN NSString * const fetch_faultErrList ;
//发布售后
UIKIT_EXTERN NSString * const fetch_afterSalesNew;
//查看售后
UIKIT_EXTERN NSString * const fetch_afterSalesDetails ;
//新增评价
UIKIT_EXTERN NSString * const fetch_insertPingJiaData;
//查看评价
UIKIT_EXTERN NSString * const fetch_pingJiaDetail;

@end
