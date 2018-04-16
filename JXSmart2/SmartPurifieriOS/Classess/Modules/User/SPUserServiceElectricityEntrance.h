//
//  SPUserServiceElectricityEntrance.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "spuserAddressListModel.h"

@interface SPUserServiceElectricityEntrance : NSObject


/**
 获取我的页面

 @return vc
 */
+(UIViewController*)getUserViewController ;


 /** 获取家庭地址vc */
+(UIViewController*)getUserHomeAddressController:(void (^)(spuserAddressListModel* model))successHander;


+(UIViewController*)orderDeitalController:(NSString*)orderid;


+(UIViewController*)fetchShoppingCarVC;


+(UIViewController*)fethMAPViewForLocation:(id)placemark;


@end
