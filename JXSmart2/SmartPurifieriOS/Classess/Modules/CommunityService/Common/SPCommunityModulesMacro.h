//
//  SPCommunityModulesMacro.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 定义常量的文件夹
 */
@interface SPCommunityModulesMacro : NSObject

/**  获得广告 */
UIKIT_EXTERN NSString * const communityGetAdvURL ;

/**  保洁详情列表 */
UIKIT_EXTERN NSString * const cleanDeitalURL ;

/**  填写发布接口 */
UIKIT_EXTERN NSString * const publishURL ;

/**  保洁服务列表 */
UIKIT_EXTERN NSString * const serviceListURL ;

/**  保洁服务详情 */
UIKIT_EXTERN NSString * const doultonDetailsURL ;

/**  社区首页按钮 */
UIKIT_EXTERN NSString * const pushtotalURL ;

//合肥市 开放
UIKIT_EXTERN NSString * const communityUserCount;

//社区发布新的
UIKIT_EXTERN NSString * const COMMUNITYPUBLISH;

//咨询量接口
UIKIT_EXTERN NSString * const CommunityConsultingUrl;

UIKIT_EXTERN NSString *const CommunityReportService;

//阿里支付
UIKIT_EXTERN NSString * const communityPublishAliPAY;
//微信支付
UIKIT_EXTERN NSString * const communityPublishWeChatPay;
//银联支付
UIKIT_EXTERN NSString * const communityPublishUnionPay;



@end
