//
//  SPUserServiceElectricityEntrance.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPUserServiceElectricityEntrance.h"

#import "SPUserAddressListViewController.h"
#import "OrderDeitalViewController.h"
#import "SPMapAroundInfoViewController.h"

@implementation SPUserServiceElectricityEntrance

/**
 获取我的页面
 
 @return vc
 */
+(UIViewController*)getUserViewController{

    UIStoryboard * story = [UIStoryboard storyboardWithName:@"User" bundle:nil];
    
    return story.instantiateInitialViewController ;
    
    //SPUserViewController *userVC = [[SPUserViewController alloc]init];

    //return userVC;
    
}

+(UIViewController*)fetchShoppingCarVC{

    UIStoryboard * story = [UIStoryboard storyboardWithName:@"User" bundle:nil];
    
    UIViewController * vc  = [story instantiateViewControllerWithIdentifier:@"JXShopingCarViewControllerXBID"];
    
  
    return vc;

}


/** 获取家庭地址vc */
+(UIViewController*)getUserHomeAddressController:(void (^)(spuserAddressListModel* model))successHander{



    UIStoryboard * story = [UIStoryboard storyboardWithName:@"User" bundle:nil];
    
    SPUserAddressListViewController * vc  = [story instantiateViewControllerWithIdentifier:@"SPUserAddressListViewControllerXBID"];
    
    [vc setChooseAddressHandle:^(spuserAddressListModel *model) {
        
        if (successHander) {
            successHander(model);
        }
        
    }];

    return vc ;
}

+(UIViewController*)orderDeitalController:(NSString*)orderid{
   
    OrderDeitalViewController *vc =[[OrderDeitalViewController alloc]init];
 
    vc.OrderId = orderid;
    
    vc.status = OrderState_NonPayment;

    return vc;
    
}

+(UIViewController*)fethMAPViewForLocation:(id)placemark{

    //SPMapAroundInfoViewControllerXBID
    
    NSAssert([placemark isKindOfClass:[NSArray class]], @"数据类型应为数组");
    
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"User" bundle:nil];
    
    SPMapAroundInfoViewController * vc  = [story instantiateViewControllerWithIdentifier:@"SPMapAroundInfoViewControllerXBID"];
    
    NSArray * place = placemark ;
    
    vc.endPoint = CLLocationCoordinate2DMake([place[0] doubleValue], [place[1] doubleValue]);
    
    vc.addressname = place[2];
    
    return vc ;
}

@end
