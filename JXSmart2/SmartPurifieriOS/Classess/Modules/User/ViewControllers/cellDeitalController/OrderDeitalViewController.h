//
//  OrderDeitalViewController.h
//  SmartPurifieriOS
//
//  Created by yuan on 2016/11/25.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseViewController.h"

@interface OrderDeitalViewController : SPBaseViewController


@property (nonatomic,copy) NSString *OrderId;

@property (nonatomic,assign) OrderState status;


@property (nonatomic, copy) void (^delBlock)(NSString* order_on);

@end
