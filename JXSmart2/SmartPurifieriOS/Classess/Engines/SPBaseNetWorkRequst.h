//
//  SPBaseNetWorkRequst.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/14.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SPBaseNetWorkRequstDefine.h"


/**
 网络请求基本类
 */
@interface SPBaseNetWorkRequst : NSObject


/**
 网络请求方法

 @param typeMethod      请求类型
 @param userIdentifier  是否需要用户标示
 @param param           参数
 @param url             地址
 @param didSuccessBlock 成功
 @param didFailereBlock 失败
 */
+(void)startNetRequestWithTypeMethod:(RequestMethod)typeMethod
                isNeedUserIdentifier:(BOOL)userIdentifier
                     didParam:(id)param
                    didUrl:(NSString*)url
                didSuccess:(RequestSuccessBlock)didSuccessBlock
                     didFailed:(RequestFailureBlock)didFailereBlock;


+(void)uploadWithImage:(UIImage*)image
                   url:(NSString *)url
              filename:(NSString *)filename
                  name:(NSString *)name
                params:(NSDictionary *)params
                   progress:(void (^)(double bytesProgress))progressBlock
                 didSuccess:(RequestSuccessBlock)successBlock
                    didFail:(RequestFailureBlock)failBlock;

+(void)uploadWithFile:(NSString*)filepath
                   url:(NSString *)url
              filename:(NSString *)filename
                  name:(NSString *)name
                params:(NSDictionary *)params
              progress:(void (^)(double bytesProgress))progressBlock
            didSuccess:(RequestSuccessBlock)successBlock
               didFail:(RequestFailureBlock)failBlock;

@end
