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
#import <SVProgressHUD.h>
#import <GTSDK/GeTuiSdk.h>

@implementation SPBaseResponseHandler

/**
 网络失败的集中处理
 @param dataTask     返回的处理
 @param error        错误描述
 @param errorHandler 回调
 */
+ (void)errorHandlerWithSessionDataTask:(NSURLSessionDataTask *)dataTask  error:(NSError *)error errorHandler:(void(^)(NSString *errorStr))errorHandler parameters:(id)param{
    
    

    NSLog(@"错误内容...%@ \n请求地址...%@ \n请求参数... %@ ",error.localizedDescription,dataTask.currentRequest.URL.absoluteString,[param mj_JSONString]);
    
    NSString *msg = error.localizedDescription;
   
    if([msg rangeOfString:@"NSURLErrorDomain"].location !=NSNotFound || [msg rangeOfString:@"Could not connect to the server"].location!=NSNotFound|| [msg rangeOfString:@"The Internet connection"].location!=NSNotFound)
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
    //{"result":3,"msg":"安全验证失败","errcode":0} 
    //URL
    NSString * absoluteString = dataTask.currentRequest.URL.absoluteString ;
    
    //返回内容
    
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        
        errorHandler(@"服务器错误");
        
        return ;
    }
    
    NSDictionary * responseDic = responseObject ;
    
    NSInteger result = [[responseDic objectForKey:@"result"] integerValue] ;
    
    id responseData  = [responseDic objectForKey:@"data"];
    
    id requestParam = [SPSmartInterfaceEncryption decryptionResponseData:[param mj_JSONString] url:absoluteString] ;
    
    NSLog(@"返回内容...%@ \n请求地址... %@ \n请求参数...%@\n",[responseObject mj_JSONString],absoluteString,requestParam);
    
    //业务请求成功
    if (result == 0) {
        
        //是否包含不解密的url
        if ([SPSmartInterfaceEncryption isContainsWithNotDecryption:absoluteString]) {
        
            successHandler(responseData);
            
        }else{
        
            id obj = [SPSmartInterfaceEncryption decryptionResponseData:responseData url:absoluteString];
            
            NSLog(@"返回Data内容...%@ \n",obj);
            
            successHandler([obj mj_JSONObject]);
            
        }
        
        [QSHCache qsh_saveDataCache:responseObject forParam:requestParam url:absoluteString];
    
    }else{

        NSString * message = [responseDic objectForKey:@"msg"];
        
        if (result == 4) {
            
            SPUserModel * model  = [SPUserModel fetchPartnerModelDF];
            
            [GeTuiSdk unbindAlias:model.partnerNumber andSequenceNum:model.partnerNumber andIsSelf:YES];
            
            [SPUserModel delCurrentPartnerModel];
            
            [SVProgressHUD showErrorWithStatus:message];
         
            [((AppDelegate*)[UIApplication sharedApplication].delegate) setLoginVCWithRootViewController];

        }else if ([absoluteString rangeOfString:URL_FetchTiXianMoney].location != NSNotFound && (result == 3||result == 5)){
        
            if (errorHandler) {
                
                errorHandler(@(result));
            }
            
        }else{
        
            if (!message || message.length==0) {
                
                message  = @"获取数据失败";
            }
            
            if (errorHandler) {
                
                errorHandler(message);
            }
            
        }
    }

}


@end
