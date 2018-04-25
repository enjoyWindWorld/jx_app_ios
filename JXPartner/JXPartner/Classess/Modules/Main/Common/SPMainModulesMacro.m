//
//  SPMainModulesMacro.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPMainModulesMacro.h"

@implementation SPMainModulesMacro

/**  获取验证码 */
NSString * const registerSendSMSCodeURL  = @"smvc/partner/registerCode.v";

/**  用户注册 */
 NSString * const userRegisterURL = @"smvc/partner/registereds.v";

/**  用户登录 */
 NSString * const userLoginURL = @"smvc/partner/toLogin.v";

/**  修改密码 */
NSString * const userChangePasswordURL = @"smvc/partner/modifyPwdBack.v";

/** 校验验证码 */
NSString * const userCheckSMSCode = @"smvc/partner/checkCode.v";

//上传图片
NSString * const fileUpLoad = @"smvc/file/fileupload";

@end
