//
//  SPMainLoginBusiness.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPMainLoginBusiness.h"
#import "SPUserModel.h"

@implementation SPMainLoginBusiness

/**
 用户注册
 
 @param param phoneNum<Y>,password<Y>
 @param successBlock 结果
 @param failer 提示
 */
-(void)userRegister:(NSDictionary*)param
            success:(BusinessSuccessBlock)successBlock
             failer:(BusinessFailureBlock)failer{


    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:userRegisterURL didSuccess:^(id response) {
        
        if (successBlock) {
            successBlock(response);
        }
    } didFailed:^(NSString *errorMsg) {
        if (failer) {
            failer(errorMsg);
        }
        
    }];
    

}

/**
 发送验证码
 
 @param param  phoneNum<Y>
 @param successBlock 结果
 @param failer 提示语
 */
-(void)userRegisterSMSCode:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer{

    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:registerSendSMSCodeURL didSuccess:^(id response) {
        
        if (successBlock) {
            successBlock(response);
        }
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];


}

/**
 校验验证码验证
 
 @param param phoneNum<Y>,code<Y>
 @param successBlock 成功
 @param failereBlock 失败
 */
-(void)userCheckSMSCode:(NSDictionary*)param
                success:(BusinessSuccessBlock)successBlock
                failere:(BusinessFailureBlock)failereBlock{

    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:userCheckSMSCode didSuccess:^(id response) {
        if (successBlock) {
            
            successBlock (response);
        }
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failereBlock) {
            
            failereBlock (errorMsg);
        }
    }];
    
    
}

/**
 用户登录
 
 @param param  phoneNum<Y>,password<Y>
 @param successBlock 结果
 @param failer 提示语
 */
-(void)userLogin:(NSDictionary*)param
         success:(BusinessSuccessBlock)successBlock
          failer:(BusinessFailureBlock)failer{
    

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:userLoginURL didSuccess:^(id response) {
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * modelArr = [SPUserModel mj_objectArrayWithKeyValuesArray:response];
            
            if (modelArr.count>0) {
                
                SPUserModel * user = modelArr[0] ;
                
                if (successBlock) {
                    
                    successBlock(user);
                }
            }
        }else{
            
            if (failer) {
                failer(@"数据错误");
            }
        }
        
    } didFailed:^(NSString *errorMsg) {
        if (failer) {
            failer(errorMsg);
        }
        
    }];
    
}

/**
 找回密码
 
 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)userForgetPassword:(NSDictionary*)param
                  success:(BusinessSuccessBlock)successBlock
                   failer:(BusinessFailureBlock)failer{
        
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:userChangePasswordURL didSuccess:^(id response) {
        
        if (successBlock) {
            successBlock(response);
        }
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
        
    }];
    
    

}

//上传图片
+(void)uploadImageFile:(UIImage*)image
                   parma:(NSDictionary*)dic
                 success:(BusinessSuccessBlock)success
                 failere:(BusinessFailureBlock)failere{
    
    [SPBaseNetWorkRequst uploadWithImage:image url:fileUpLoad filename:nil name:@"file" params:dic progress:nil didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSString * imgurl = @"";
            
            for (NSDictionary * dic in response) {
                
                imgurl = [dic objectForKey:@"imgUrl"];
                
            }
            
            if (success) {
                success(imgurl);
            }
            
        }else{
            
            if (failere) {
                failere (BUSINESSDATAERR);
            }
        }
        
    } didFail:^(NSString *errorMsg) {
        
        if (failere) {
            failere (errorMsg);
        }
        
    }];
}




@end
