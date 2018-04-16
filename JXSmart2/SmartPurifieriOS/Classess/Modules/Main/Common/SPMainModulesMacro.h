//
//  SPMainModulesMacro.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
  定义常量的文件夹
 */
@interface SPMainModulesMacro : NSObject


/**  获取验证码 */
UIKIT_EXTERN NSString * const registerSendSMSCodeURL;

/**  用户注册 */
UIKIT_EXTERN NSString * const userRegisterURL ;

/**  用户登录 */
UIKIT_EXTERN NSString * const userLoginURL ;

/**  修改密码 */
UIKIT_EXTERN NSString * const userChangePasswordURL;

 /** 校验验证码 */
UIKIT_EXTERN NSString * const userCheckSMSCode ;

/** 上传图片 */
UIKIT_EXTERN NSString * const fileUpLoad;



@end
