//
//  SPHomePageElectricityEntrance.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 模块桥接桥
 */
@interface SPHomePageElectricityEntrance : NSObject


/**
 获取主页vc

 @return home
 */
+(UIViewController*)getHomePageViewController;



/**
 前往支付

 @param model 对应的数据模型
 @return 控制器
 */
+(UIViewController*)getPayDetailViewController:(id)model;



/**
 前往填写支付页面

 @param model 数据模型
 @return
 */
+(UIViewController*)fetchWirtePayViewController:(id)model;



@end
