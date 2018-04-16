//
//  SPSmartInterfaceEncryption.h
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/22.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 加密类
 */
@interface SPSmartInterfaceEncryption : NSObject


/**
 加密实现

 @param param 网络请求参数
 @param isEncrypation 是否加密
 @param url 网络请求url
 @return 加密后数据
 */
+(id)encryptionRequestWithParam:(id)param isEncrypation:(BOOL)isEncrypation url:(NSString*)url;


/**
 解密实现

 @param data 要解密的数据
 @param url url
 @return 返回解密的对象
 */
+(id)decryptionResponseData:(id)data url:(NSString*)url;


/**
 是否包含不加密的url

 @param url url
 @return yes or no
 */
+(BOOL)isContainsWithNotDecryption:(NSString*)url;


@end
