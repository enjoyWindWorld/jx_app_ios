//
//  SPUserModulesMacro.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPUserModulesMacro.h"

@implementation SPUserModulesMacro

/**  修改头像 */
 NSString * const userChangeHeadIcoURL = @"smvc/user/test/modifyHead.v";

/** 用户-我的净水机列表 */
 NSString * const userPurifierList  = @"smvc/product/waterCleaner.v";
//@"forkliftn/smvc/userwappush/waterCleaner.v";

/** 访问净水器滤芯状态 */
 NSString * const userPurifierDetail =@"smvc/userwappush/doulton.v";

//我的订单
 NSString * const userMyOrder =@"smvc/order/myOrders.v";


//我的订单详情
NSString * const userMyOrderDetail =@"smvc/order/orderuDetail.v";

//我的订单删除
NSString * const userOrderDel =@"smvc/order/deleteorder.v";

/** 我的昵称 */
NSString * const userNickName =@"smvc/user/test/modifyNickName.v";

/** 我的性别 */
NSString * const userSex =@"smvc/user/test/modifySex.v";

/** 我的签名 */
NSString * const userSign =@"smvc/user/test/modifySign.v";

/** 我的地址 */
NSString * const userHomeAddressList =@"smvc/user/test/getAddress.v";

/** 新增、修改地址 */
 NSString * const userHomeAddressModify = @"smvc/user/test/modifyAddress.v";

//意见反馈
 NSString * const userOption = @"smvc/setup/addOption.v";


//NSString * const userAddress =@"smvc/user/test/getAddress.v";
//>>>>>>> origin/master

/** 删除地址 */
 NSString * const userHomeAddressDelete = @"smvc/user/test/deleteAddress.v";

/** 商家发布 */
NSString * const userMerchantRelease = @"smvc/userwappush/mydoulton.v";

/** 分享绑定 */
NSString * const userSharePhoneNum = @"smvc/user/test/shareDevice.v";


/** 获取消息列表 */
 NSString * const userMessageList  = @"smvc/product/queryAllMess.v";

/** 余量查询 */
 NSString * const userClarifierDetailCost=@"smvc/product/myproductServiceDetail.v";

/** 续费订单接口 */
 NSString * const UserClarifierCostPay = @"smvc/order/renewalsOrder.v";

/** 更改手机号 */
NSString * const userModifyPhoneNum=@"smvc/user/test/modifyPhoneNum.v";

/** 更改某条消息为已读 */
 NSString * const userChangeMessageWithRead = @"smvc/product/alterMessStatus.v";

/** 删除消息 */
 NSString * const userDeleteMessage = @"smvc/message/deleteMessage.v";

/** 消息未读数 */
 NSString * const userNotReadMessageCount = @"smvc/message/queryMessages.v";

/** 订单续费详情 */
NSString * const userOrderRenewalDetail = @"smvc/order/ordeAgainDetail.v";

/** 社会化分享 */
NSString * const userhShareURL = @"smvc/user/test/shareContent.v";

//我的推广
NSString * const userAllPromoter = @"smvc/release/AllPromoter.v";

#pragma mark - 售后模块
//售后列表
NSString * const fetch_user_afterLists = @"after/users/afterofappraise.v";
//选择设备
NSString * const fetch_chooseProductlist = @"after/users/filterreplacement.v";
//选择滤芯
NSString * const fetch_chooseTrafficlist = @"after/users/cartridgereplacement.v";
//故障列表
NSString * const fetch_faultErrList = @"after/users/fault.v";
//发布售后
NSString * const fetch_afterSalesNew = @"after/users/addfilterafter.v";
//查看售后
NSString * const fetch_afterSalesDetails  = @"after/users/afterthedetails.v";
//新增评价
NSString * const fetch_insertPingJiaData = @"after/users/appraise.v";
//查看评价
NSString * const fetch_pingJiaDetail = @"after/users/appraisesparticulars.v";
@end
