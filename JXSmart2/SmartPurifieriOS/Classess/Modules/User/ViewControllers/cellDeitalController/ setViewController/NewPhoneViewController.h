//
//  NewPhoneViewController.h
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/10.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPUserModulesBusiness.h"

@interface NewPhoneViewController : UIViewController
@property (nonatomic, copy) void (^block)(NSString *phoneNum);

@end
