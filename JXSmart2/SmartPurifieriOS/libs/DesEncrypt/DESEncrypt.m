//
//  DESEncrypt.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/20.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "DESEncrypt.h"
#import <CommonCrypto/CommonCrypto.h>
#import "GTMDefines.h"
#import "GTMBase64.h"

@implementation DESEncrypt

static const Byte iv[] = {1,2,3,4,5,6,7,8};

#pragma mark- 加密算法
+(NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key
{
    return [self encrypt:plainText encryptOrDecrypt:kCCEncrypt key:key];
    
}
#pragma mark- 解密算法
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key
{
     return [self encrypt:cipherText encryptOrDecrypt:kCCDecrypt key:key];

}


+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key
{
    const void *dataIn;
    
    size_t dataInLength;
    
    if (encryptOperation == kCCDecrypt)//传递过来的是decrypt 解码
    {
        //解码 base64
        NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];//转成utf-8并decode
        
        dataInLength = [decryptData length];
        
        dataIn = [decryptData bytes];
    }
    else  //encrypt
    {
        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
       
        dataInLength = [encryptData length];
        
        dataIn = (const void *)[encryptData bytes];
    }
    
    /*
     DES加密 ：用CCCrypt函数加密一下，然后用base64编码下，传过去
     DES解密 ：把收到的数据根据base64，decode一下，然后再用CCCrypt函数解密，得到原本的数据
     */
    CCCryptorStatus ccStatus;
   
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
   
    size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
   
    size_t dataOutMoved = 0;
    
    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    
    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
   
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    
    const void *vkey = (const void *) [key UTF8String];

    ccStatus = CCCrypt(encryptOperation,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySizeDES,
                       iv,
                       dataIn,
                       dataInLength,
                       (void *)dataOut,
                       dataOutAvailable,
                       &dataOutMoved);
    
    NSString *result = nil;
    
    if (encryptOperation == kCCDecrypt)//encryptOperation==1  解码
    {
       
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved] encoding:NSUTF8StringEncoding];
    }
    else //encryptOperation==0  （加密过程中，把加好密的数据转成base64的）
    {
       
        NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
       
        result = [GTMBase64 stringByEncodingData:data];
    }
    
    free(dataOut);
    
    return result;
}


@end
