//
//  SPMainLoginBusiness.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseBusiness.h"
#import "SPMainModulesMacro.h"


@interface SPMainLoginBusiness : SPBaseBusiness





/**
 发送验证码

 @param param  phoneNum<Y>
 @param successBlock 结果
 @param failer 提示语
 */
-(void)userRegisterSMSCode:(NSDictionary*)param
            success:(BusinessSuccessBlock)successBlock
             failer:(BusinessFailureBlock)failer;


/**
 校验验证码验证

 @param param phoneNum<Y>,code<Y>
 @param successBlock 成功
 @param failereBlock 失败
 */
-(void)userCheckSMSCode:(NSDictionary*)param
                success:(BusinessSuccessBlock)successBlock
                failere:(BusinessFailureBlock)failereBlock;



/**
 用户登录
 
 @param param  phoneNum<Y>,password<Y>
 @param successBlock 结果
 @param failer 提示语
 */
-(void)userLogin:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer;




/**
 找回密码

 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)userForgetPassword:(NSDictionary*)param
         success:(BusinessSuccessBlock)successBlock
          failer:(BusinessFailureBlock)failer;

//注册
-(void)requestUserRegister:(NSDictionary * )params
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer;


/**
 上传图片数据
 
 @param image 数据
 @param dic 字典参数
 @param success 成功
 @param failere 失败
 */
+(void)uploadImageFile:(UIImage*)image
                   parma:(NSDictionary*)dic
                 success:(BusinessSuccessBlock)success
                 failere:(BusinessFailureBlock)failere;





@end
