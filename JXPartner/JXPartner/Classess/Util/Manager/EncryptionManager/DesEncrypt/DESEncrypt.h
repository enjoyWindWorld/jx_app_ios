//
//  DESEncrypt.h
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/20.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESEncrypt : NSObject
//加密方法
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
//解密方法
+(NSString *) decryptUseDES:(NSString *)cipherText key:(NSString *)key;

@end
