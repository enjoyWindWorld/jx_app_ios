//
//  SPGoPayDetailViewController.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseViewController.h"
@class OrderDetailModel;
@class SPAddOrderModel;
@class JXCommunityGoPay;
/**
 支付详情
 */
@interface SPGoPayDetailViewController : SPBaseViewController

@property (nonatomic,strong) SPAddOrderModel * writePayModel ;

@property (nonatomic,strong) OrderDetailModel * orderModel;

@property (nonatomic,strong) JXCommunityGoPay * communityPay ;

@end
