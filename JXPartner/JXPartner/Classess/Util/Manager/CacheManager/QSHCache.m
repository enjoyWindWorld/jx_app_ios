//
//  QSHCache.m
//  
//
//  Created by Qin on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "QSHCache.h"
#import "YYCache.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "SPSmartInterfaceEncryption.h"

@interface QSHCache ()

@property (nonatomic, strong) YYCache *dataCache;

@end

@implementation QSHCache

+(instancetype)shareManger {
    
    static QSHCache * manger = nil ;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manger = [[QSHCache alloc] init];
        
        
    });
    
    return manger ;
}

static NSString *const qshCache = @"qsh_Cache";


/**
 缓存保存 解密后的
 
 @param data 缓存数据
 @param param url 请求参数
 @param url url
 */
+ (void)qsh_saveDataCache:(id)data forParam:(id)param url:(NSString*)url{

    if (![QSHCache qsh_needContainsCache:url]) {
        
        return;
    }
    
    if (![QSHCache qsh_needContainsWithPage:param]) {
        
        return;
    }
    
    //解密
    id obj = nil;

    if ([SPSmartInterfaceEncryption isContainsWithNotDecryption:url]) {
        
       obj = [data objectForKey:@"data"];
        
    }else{
    
        obj = [SPSmartInterfaceEncryption decryptionResponseData:[data objectForKey:@"data"] url:url];

    }
    
     NSString * key = [NSString stringWithFormat:@"%@%@",url,[param mj_JSONString]];
    
     [[QSHCache shareManger].dataCache setObject:obj forKey:key];
    
   
}


/**
 读取缓存
 
 @param param url
 @param url url
 @param success 网络请求中的block
 @return yes 走下一步
 */
+ (BOOL)qsh_ReadCacheforParam:(id)param url:(NSString*)url successBlock:(RequestSuccess)success{
    

    NSString * key = [NSString stringWithFormat:@"%@:%@/%@/%@%@",SmartPurifierHostURL,HOST_PORT,HOST_DIRURL,url,param==nil?@"{}":[param mj_JSONString]];
    
    id obj = nil;
    
    obj = (NSString *)[[QSHCache shareManger].dataCache objectForKey:key];
    
    if (success&&obj) {
        
        success([obj mj_JSONObject]);
    }

    AFNetworkReachabilityManager * manager  = [AFNetworkReachabilityManager sharedManager];
    
    return manager.networkReachabilityStatus==AFNetworkReachabilityStatusUnknown?YES:manager.isReachable;
}


+(BOOL)qsh_needContainsCache:(NSString*)url{
    
    //默认不需要
    __block BOOL isok = NO;
    
    [[[self class] arrContainsUrl] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString * containurl  = obj;
        
        if ([url containsString:containurl]) {
            
            isok = YES;
            
            *stop = YES;
        }
        
    }];
    
    return isok;
}

+(BOOL)qsh_needContainsWithPage:(id)param{
    
    //默认需要
    __block BOOL isok = YES;
    
    if ([param isKindOfClass:[NSString class]] && param) {
        
        NSDictionary * dic = [param mj_JSONObject];
        
        [dic.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString * key = obj;
            
            if ([key isEqualToString:@"page"]) {
            
                NSString * value = [dic objectForKey:key];
                
                if ([value integerValue]!=1) {
                    
                    isok = NO;
                    
                    *stop = YES;
                }
            }
            
            
        }];
    }
    
    return isok;
}


+(NSArray*)arrContainsUrl{
    
    return @[URL_FETCHPARTNERORDERLIST,URL_FETCHPARNERSUBLIST,URL_FetchParnerSubOrderList,URL_FetchPartnerMessageList,URL_FetchTiXianHistory];
}


+ (CGFloat)qsh_GetAllHttpCacheSize
{
    
    
    // 总大小
    unsigned long long diskCache = [[QSHCache shareManger].dataCache.diskCache totalCost];
    
    NSString *sizeText = nil;
    
    if (diskCache >= pow(10, 9)) {
        // size >= 1GB
        sizeText = [NSString stringWithFormat:@"%.2fGB", diskCache / pow(10, 9)];
    } else if (diskCache >= pow(10, 6)) { // 1GB > size >= 1MB
        sizeText = [NSString stringWithFormat:@"%.2fMB", diskCache / pow(10, 6)];
    } else if (diskCache >= pow(10, 3)) { // 1MB > size >= 1KB
        sizeText = [NSString stringWithFormat:@"%.2fKB", diskCache / pow(10, 3)];
    } else { // 1KB > size
        sizeText = [NSString stringWithFormat:@"%zdB", diskCache];
    }
    
    CGFloat cacheSize = diskCache;

    return cacheSize ;

}

+ (BOOL)qsh_IsCache:(NSString *)key {
    
    return [[QSHCache shareManger].dataCache containsObjectForKey:key];
}

+ (void)qsh_RemoveChache:(NSString *)key {
    
    [[QSHCache shareManger].dataCache removeObjectForKey:key withBlock:nil];
}

+ (void)qsh_RemoveAllCache {
    
    [[QSHCache shareManger].dataCache removeAllObjects];
}




-(YYCache *)dataCache{

    if (_dataCache == nil) {
        
        _dataCache =[YYCache cacheWithName:qshCache];
    }
    
    return _dataCache;
}



@end
