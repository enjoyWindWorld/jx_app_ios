//
//  SPCommunityModulesMacro.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPCommunityModulesMacro.h"

@implementation SPCommunityModulesMacro

/**  获得广告 */
NSString * const communityGetAdvURL = @"smvc/launch/test/getAdver.v";


/** 保洁列表*/
NSString * const cleanDeitalURL = @"smvc/user/test/registerCode.v";

/** 发布*/
NSString * const publishURL = @"smvc/user/addPublish.v";

/** 服务列表
*/NSString * const serviceListURL = @"smvc/user/publishList.v";

/** 服务详情*/
NSString * const doultonDetailsURL = @"smvc/userwappush/doultondetails.v";

/** 社区首页按钮列表*/
NSString * const pushtotalURL = @"smvc/wapPush/wappushtotal.v";

//合肥市 开放
NSString * const communityUserCount = @"smvc/user/test/citybutton.v";

//社区发布新的
NSString * const COMMUNITYPUBLISH = @"smvc/release/addreleaseorder.v";

//咨询量接口
 NSString * const CommunityConsultingUrl = @"smvc/userwappush/inquiries.v";

 NSString *const CommunityReportService = @"smvc/release/reportbusinessman.v";

//阿里支付
 NSString * const communityPublishAliPAY = @"smvc/releasepay/alipay.v";
//微信支付
 NSString * const communityPublishWeChatPay = @"smvc/releasepay/wxpay.v";
//银联支付
 NSString * const communityPublishUnionPay = @"smvc/releasepay/unionpay.v";


@end
