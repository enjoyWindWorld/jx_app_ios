//
//  SPBaseResponseHandler.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/14.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseResponseHandler.h"
#import <MJExtension.h>
#import "SPSmartInterfaceEncryption.h"
#import "QSHCache.h"
#import "SPLoginPageViewController.h"
#import "AppDelegate.h"
#import "SPUserModel.h"

@implementation SPBaseResponseHandler

//      {"result":0,"data":"123456","errcode":0,"msg":"ok"}


/**
 网络失败的集中处理
 @param dataTask     返回的处理
 @param error        错误描述
 @param errorHandler 回调
 */
+ (void)errorHandlerWithSessionDataTask:(NSURLSessionDataTask *)dataTask  error:(NSError *)error errorHandler:(void(^)(NSString *errorStr))errorHandler parameters:(id)param{
    
    

    NSLog(@"错误内容...%@ \n请求地址...%@ \n请求参数... %@ ",error.localizedDescription,dataTask.currentRequest.URL.absoluteString,[param mj_JSONString]);
    
    
    
    NSLog(@"搓麻   %ld",(long)error.code);
    
    NSString *msg = error.localizedDescription;
   
    if([msg rangeOfString:@"NSURLErrorDomain"].location !=NSNotFound)
    {
        if (errorHandler) {
            
            errorHandler(@"连接服务器失败");
        }
        
    }else{
    
        if (errorHandler) {
            
            errorHandler(error.localizedDescription);
        }
    }
    

}



/**
 网络成功的集中处理
 
 @param dataTask       返回要做的处理
 @param responseObject 返回的数据
 @param successHandler 成功的回调
 @param errorHandler   数据处理失败回调
 */
+ (void)successHandlerWithSessionDataTask:(NSURLSessionDataTask *)dataTask
                           responseObject:(id)responseObject
                           successHandler:(void(^)(id newResponseObject))successHandler errorHandler:(void(^)(id errorStr))errorHandler  parameters:(id)param{
    
    NSLog(@"返回内容...%@",[responseObject mj_JSONString]);
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        //result 为0
        if ([[responseObject objectForKey:@"result"]integerValue]==0) {
            
            NSString * url = dataTask.currentRequest.URL.absoluteString ;
            
            if (successHandler) {
   
                if ([[responseObject allKeys]containsObject:@"data"])
                {
                    
                    if ([SPSmartInterfaceEncryption isContainsWithNotDecryption:url]) {
                        
                        successHandler([responseObject objectForKey:@"data"]);
                        
                        NSLog(@"返回内容...%@ \n请求地址... %@ \n请求参数...%@\n",[responseObject objectForKey:@"data"],url,[SPSmartInterfaceEncryption decryptionResponseData:[param mj_JSONString] url:url]);
                        
                    }else{
                    
                        id obj = [SPSmartInterfaceEncryption decryptionResponseData:[responseObject objectForKey:@"data"] url:url];
                        
                         NSLog(@"返回内容...%@ \n请求地址... %@ \n请求参数...%@\n",obj,url,[SPSmartInterfaceEncryption decryptionResponseData:[param mj_JSONString] url:url]);
                        
                         successHandler([obj mj_JSONObject]);
                    }
                    
                    [QSHCache qsh_saveDataCache:responseObject forParam:[SPSmartInterfaceEncryption decryptionResponseData:[param mj_JSONString] url:url]url:url];

                    
                }
                else{
                    NSString * url = dataTask.currentRequest.URL.absoluteString ;
                    
                    NSLog(@"返回内容...%@ \n请求地址... %@ \n请求参数...%@\n",@"",url,[SPSmartInterfaceEncryption decryptionResponseData:[param mj_JSONString] url:url]);
                
                    successHandler(nil);
                }

            }
            
        }else{
            
            
            
            NSLog(@"\n失败参数...%@\n",[SPSmartInterfaceEncryption decryptionResponseData:[param mj_JSONString] url:nil]);
            
            NSString * url = dataTask.currentRequest.URL.absoluteString ;
            
            NSString * message = [responseObject objectForKey:@"msg"];
            
            if ([[responseObject objectForKey:@"result"]integerValue]==3 && [url rangeOfString:WaterQuantity].location != NSNotFound) {
                
                if (errorHandler) {
                    
                    errorHandler(@{@"isBind":@"0"});
                }
                
                return ;
            }
            
           
            if (([[self class]isContainPayUrl:url])&&[message isEqualToString:@"-5"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:SPElectricityPayResult object:nil userInfo:@{@"result":[NSNumber numberWithInteger:1],@"message":@"支付成功"}];
                
                return ;
            }
                    
            if (!message || message.length==0) {
                
                message  = @"获取数据失败";
            }
            
            if (errorHandler) {
                
                errorHandler(message);
            }
            
            //result 为 密码
            if ([[responseObject objectForKey:@"result"]integerValue]==3 && [url rangeOfString:userLoginURL].location!=NSNotFound) {
                
                AppDelegate * app   = (AppDelegate*)[UIApplication sharedApplication].delegate;

                if ([app.window.rootViewController isKindOfClass:[UITabBarController class]]) {
                    
                    [[SPUserModel getUserLoginModel] delUserLoginModel];
                    
                    [app setLoginVCWithRootViewC];
                }

            }

            
        }

    }
  
}


+(BOOL)isContainPayUrl:(NSString*)url{

    NSArray * urlArr = @[communityPublishAliPAY,communityPublishWeChatPay,communityPublishUnionPay,productAliPayParam,productWeChatPayParam,productUnionpayParam];
    
    __block BOOL isok = NO ;
    
    [urlArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString * urlstring = obj ;
        
        if ([url rangeOfString:urlstring].location!=NSNotFound) {
            
            isok = YES;
            
            *stop = YES ;
        }
    }];
    
    return isok ;
}



@end
