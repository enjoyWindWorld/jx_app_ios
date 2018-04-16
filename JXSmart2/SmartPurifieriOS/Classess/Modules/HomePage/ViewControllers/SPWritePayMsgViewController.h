//
//  SPWritePayMsgViewController.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseViewController.h"

@class SPPurifierModel;
/**
 填写支付信息
 */
@interface SPWritePayMsgViewController : SPBaseViewController

@property (nonatomic,strong) SPPurifierModel * payModel ;

@end

