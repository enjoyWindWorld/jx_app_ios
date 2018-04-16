//
//  SPBaseNetWorkRequst.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/14.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//



#import "SPBaseNetWorkRequst.h"
#import <AFNetworking.h>
#import "SPBaseResponseHandler.h"
#import "SPUserModel.h"
#import "AppDelegate.h"
#import "SPSmartInterfaceEncryption.h"
#import "DESEncrypt.h"
#import "ShieldEmoji.h"
#import "QSHCache.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface FactorySecurityPolicy : NSObject
@property (nonatomic,copy) NSDictionary *params;

+ (AFSecurityPolicy *)customSecurityPolicy;

@end

@implementation FactorySecurityPolicy

+(AFSecurityPolicy *)customSecurityPolicy{

    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
    
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    //AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证子域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
   
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}



@end


@interface SPBaseNetWorkRequst ()

@property (nonatomic, strong) AFHTTPSessionManager *engine;


@end

@implementation SPBaseNetWorkRequst


/**
 网络监控
 */
+(void)startMonitoring{

    AFNetworkReachabilityManager * manage = [AFNetworkReachabilityManager sharedManager];
    
    [manage startMonitoring];
    
}

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
                           didFailed:(RequestFailureBlock)didFailereBlock{

    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:param];
    
    SPUserModel * user = [SPUserModel fetchPartnerModelDF];
    
    if (userIdentifier) {
        
        if (user) {
        
            [dic setObject:user.safetyMark forKey:@"safetyMark"];
        
        }else{
            
            if (didFailereBlock) {
                
                didFailereBlock (@"登录失效，请重新登录");
            }
            
            NSAssert(NO, @"登录后再试一遍");
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
//                [((AppDelegate*)[UIApplication sharedApplication].delegate) setLoginVCWithRootViewC];

            });
            
            return ;
            
        }
    }
    
    
    
    
//    [[self class]stringReaplaceEmojiAndNewlineCharacterSet];
    
    //       缓存策略
    //     1.先判断哪些url加载缓存ss
    //     2.判断有没有网络
    //     3.如果没有网络则返回 NO
    //     4.有网，则继续请求，然后刷新内容，刷新缓存
    

    if ([QSHCache qsh_ReadCacheforParam:dic url:url successBlock:didSuccessBlock]) {
        
        //参数加密
        id encryption = [SPSmartInterfaceEncryption encryptionRequestWithParam:dic isEncrypation:YES url:url];
        
        switch (typeMethod) {
            case RequestMethod_GET:
                
                [SPBaseNetWorkRequst startRequestWithGet:encryption didUrl:url didSuccess:didSuccessBlock didFailed:didFailereBlock];
                
                break;
                
            case RequestMethod_POST:
                
                [SPBaseNetWorkRequst startRequestWithPost:encryption didUrl:url didSuccess:didSuccessBlock didFailed:didFailereBlock];
                
                break ;
                
            default:
                
                NSAssert(NO, @"扩充请求方法");
                
                break;
        }
        
    }
    else{
    
       
        if (didFailereBlock) {
            
            didFailereBlock(@"似乎已断开与互联网的连接。");
        }
        
    }
    
    

    
}

+(void)uploadWithFile:(NSString*)filepath
                  url:(NSString *)url
             filename:(NSString *)filename
                 name:(NSString *)name
               params:(NSDictionary *)params
             progress:(void (^)(double bytesProgress))progressBlock
           didSuccess:(RequestSuccessBlock)successBlock
              didFail:(RequestFailureBlock)failBlock{

    SPBaseNetWorkRequst * requet = [SPBaseNetWorkRequst shareRequst];
    
    [requet.engine POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        [formData appendPartWithFileData:[NSData dataWithContentsOfFile:filepath] name:[NSString stringWithFormat:@"%@",name] fileName:filename mimeType:@"image/jpeg"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"uploadProgress  %f",uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SPBaseResponseHandler successHandlerWithSessionDataTask:task responseObject:responseObject successHandler:successBlock errorHandler:failBlock parameters:params];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SPBaseResponseHandler errorHandlerWithSessionDataTask:task error:error errorHandler:failBlock parameters:params];
    }];

}

+(void)uploadWithImage:(UIImage*)image
                   url:(NSString *)url
              filename:(NSString *)filename
                  name:(NSString *)name
                params:(NSDictionary *)params
              progress:(void (^)(double bytesProgress))progressBlock
            didSuccess:(RequestSuccessBlock)successBlock
               didFail:(RequestFailureBlock)failBlock{
    
    if (!image) {
        
        if (failBlock) {
            
            failBlock(@"图片数据为空");
        }
        
        return ;
    }
    
    SPBaseNetWorkRequst * requet = [SPBaseNetWorkRequst shareRequst];

    [requet.engine POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSString *imageFileName = filename;
        
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            
            formatter.dateFormat = @"yyyyMMddHHmmss";
            
            NSString *str = [formatter stringFromDate:[NSDate date]];
            
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        
        NSData * imageData = nil;
        
        imageData = UIImageJPEGRepresentation(image,0.5);
        
        if (!imageData || [imageData isEqual:[NSNull null]]) {
            
            imageData  = UIImagePNGRepresentation(image);
        }
        
        if (imageData) {
            
            NSLog(@"有图。。。");
            
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%@",name] fileName:imageFileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"uploadProgress  %f",uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SPBaseResponseHandler successHandlerWithSessionDataTask:task responseObject:responseObject successHandler:successBlock errorHandler:failBlock parameters:params];
   
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SPBaseResponseHandler errorHandlerWithSessionDataTask:task error:error errorHandler:failBlock parameters:params];
    }];
}


    


/**
 get 请求
 
 @param param           参数
 @param url             地址
 @param didSuccessBlock 回调 为对应的模型
 @param didFailereBlock 回调 为错误展示
 */
+(void)startRequestWithGet:(id)param
                    didUrl:(NSString*)url
                didSuccess:(RequestSuccessBlock)didSuccessBlock
                 didFailed:(RequestFailureBlock)didFailereBlock{
    
    SPBaseNetWorkRequst * requet = [SPBaseNetWorkRequst shareRequst];
    
    [requet.engine GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SPBaseResponseHandler successHandlerWithSessionDataTask:task responseObject:responseObject successHandler:didSuccessBlock errorHandler:didFailereBlock parameters:param];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SPBaseResponseHandler errorHandlerWithSessionDataTask:task error:error errorHandler:didFailereBlock parameters:param];
    }];
    
}



/**
 POST 请求
 
 @param param           参数
 @param url             地址
 @param didSuccessBlock 回调 为对应的模型
 @param didFailereBlock 回调 为错误展示
 */
+(void)startRequestWithPost:(id)param
                     didUrl:(NSString*)url
                 didSuccess:(RequestSuccessBlock)didSuccessBlock
                  didFailed:(RequestFailureBlock)didFailereBlock{
    
    SPBaseNetWorkRequst * requet = [SPBaseNetWorkRequst shareRequst];

    
    [requet.engine POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        
        [SPBaseResponseHandler successHandlerWithSessionDataTask:task responseObject:responseObject successHandler:didSuccessBlock errorHandler:didFailereBlock parameters:param];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SPBaseResponseHandler errorHandlerWithSessionDataTask:task error:error errorHandler:didFailereBlock parameters:param];
        
    }];

}



/**
 下载方法
 
 @param param         参数
 @param url           地址
 @param saveToPath    保存的文件
 @param progressBlock 百分比
 @param successBlock  成功
 @param failBlock     失败
 */
+(void)startDownloadRequest:(NSDictionary*)param
                     didUrl:(NSString*)url
                 saveToPath:(NSString *)saveToPath
                   progress:(void (^)(double bytesProgress))progressBlock
                 didSuccess:(RequestSuccessBlock)successBlock
                    didFail:(RequestFailureBlock)failBlock{


    
}





/**
 上传方法
 
 @param param         参数
 @param url           地址
 @param progressBlock 百分比
 @param successBlock  成功
 @param failBlock     失败
 */
+(void)startUploadRequest:(NSDictionary*)param
                   didUrl:(NSString*)url
                 progress:(void (^)(double bytesProgress))progressBlock
               didSuccess:(RequestSuccessBlock)successBlock
                  didFail:(RequestFailureBlock)failBlock{

    
}



#pragma mark - getter setter

+(SPBaseNetWorkRequst *) shareRequst
{
    static dispatch_once_t onceToken;
    
    static SPBaseNetWorkRequst *baseRequest = nil;
    
    dispatch_once(&onceToken, ^{
        
        if (!baseRequest) {
            baseRequest = [[SPBaseNetWorkRequst alloc] init];
        }
    });
    return baseRequest;
}

-(AFHTTPSessionManager *)engine{

    if (!_engine) {
        
        _engine = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@:%@/%@",SmartPurifierHostURL,HOST_PORT,HOST_DIRURL]]];
        
        [_engine setSecurityPolicy:[FactorySecurityPolicy customSecurityPolicy]];
        
//        _engine.requestSerializer = [AFHTTPRequestSerializer    serializer];
//        _engine.requestSerializer = [AFJSONRequestSerializer serializer];
        
        _engine.responseSerializer = [AFJSONResponseSerializer serializer];
        //AFHTTPResponseSerializer
        _engine.requestSerializer.timeoutInterval=10;
        
        _engine.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                             @"text/html",
                                                             @"text/json",
                                                             @"text/plain",
                                                             @"text/javascript",
                                                             @"text/xml",
                                                             @"image/*, nil", nil];
        
//        [_engine.requestSerializer setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//        [_engine.requestSerializer setValue: @"application/json" forHTTPHeaderField:@"Accept"];
    }
    return _engine;
}

#pragma mark - 全局替换空格
+(NSMutableDictionary*)stringReaplaceEmojiAndNewlineCharacterSet:(NSMutableDictionary*)dic{

    [[dic allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString * keyStr = obj;
        
        NSString * valueStr = [dic objectForKey:keyStr];
       
        [dic setObject:[valueStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:keyStr];
        
    }];
    
    return dic;
}



@end
