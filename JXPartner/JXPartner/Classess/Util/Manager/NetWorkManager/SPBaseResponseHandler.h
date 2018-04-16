//
//  SPBaseResponseHandler.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/14.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPBaseResponseHandler : NSObject


/**
 网络失败的集中处理

 @param dataTask     返回的处理
 @param error        错误描述
 @param errorHandler 回调
 */
+ (void)errorHandlerWithSessionDataTask:(NSURLSessionDataTask *)dataTask  error:(NSError *)error errorHandler:(void(^)(NSString *errorStr))errorHandler parameters:(id)param;



/**
  网络成功的集中处理

 @param dataTask       返回要做的处理
 @param responseObject 返回的数据
 @param successHandler 成功的回调
 @param errorHandler   数据处理失败回调
 */
+ (void)successHandlerWithSessionDataTask:(NSURLSessionDataTask *)dataTask
                           responseObject:(id)responseObject
                           successHandler:(void(^)(id newResponseObject))successHandler errorHandler:(void(^)(id errorStr))errorHandler parameters:(id)param;


@end
