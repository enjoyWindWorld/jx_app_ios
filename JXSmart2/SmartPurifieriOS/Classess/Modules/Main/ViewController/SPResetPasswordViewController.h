//
//  SPResetPasswordViewController.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/21.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "STChildViewController.h"


/**
 重置密码
 */
@interface SPResetPasswordViewController : STChildViewController

@property(nonatomic,copy) NSString * phoneText; //手机号

@property (nonatomic,assign) SPResetPwdType type ; //类型


@end
