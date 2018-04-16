//
//  SPCommunityServiceElectricityEntrance.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 社区服务桥接
 */
@interface SPCommunityServiceElectricityEntrance : NSObject


/**
 获取社区服务vc

 @return vc
 */
+(UIViewController*)getCommunityServiceViewController;


+(UIViewController*)fetchCommunityDetailViewController:(NSString*)pubid;


@end
