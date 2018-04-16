//
//  SPHomePageElectricityEntrance.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPHomePageElectricityEntrance.h"
#import "SPGoPayDetailViewController.h"
#import "OrderDetailModel.h"
#import "SPAddOrderModel.h"
#import "JXWritePayViewController.h"
#import "JXCommunityGoPay.h"

@implementation SPHomePageElectricityEntrance

/**
 获取主页vc
 
 @return home
 */
+(UIViewController*)getHomePageViewController{

    UIStoryboard * story = [UIStoryboard storyboardWithName:@"HomePage" bundle:nil];
  
    
    return story.instantiateInitialViewController;

}

/**
 前往支付
 
 @param model 对应的数据模型
 @return 控制器
 */
+(UIViewController*)getPayDetailViewController:(id)model{

    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"HomePage" bundle:nil];
    
    SPGoPayDetailViewController * vc = [sb instantiateViewControllerWithIdentifier:@"SPGoPayDetailViewControllerXBID"];
    
    if ([model isKindOfClass:[OrderDetailModel class]]) {
        
        vc.orderModel = model;
    }else if ([model isKindOfClass:[SPAddOrderModel class]]){
    
        vc.writePayModel = model;
    }else if ([model isKindOfClass:[JXCommunityGoPay class]]){
    
        vc.communityPay = model;
    }
    
    
    return vc;
}

/**
 前往填写支付页面
 
 @param model 数据模型
 @return
 */
+(UIViewController*)fetchWirtePayViewController:(id)model{

    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"HomePage" bundle:nil];
    
    JXWritePayViewController * wirte = [sb instantiateViewControllerWithIdentifier:@"JXWritePayViewControllerXBID"];
    
    wirte.productListArr = model;
    
    return wirte;
}


@end
