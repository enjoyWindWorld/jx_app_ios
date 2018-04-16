//
//  SPSmartInterfaceEncryption.m
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/22.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPSmartInterfaceEncryption.h"
#import "DESEncrypt.h"
#import <MJExtension.h>
@implementation SPSmartInterfaceEncryption

+(id)encryptionRequestWithParam:(id)param isEncrypation:(BOOL)isEncrypation url:(NSString*)url{

    if (!isEncrypation) {
        
        return param;
    }
    
    if ([param isKindOfClass:[NSDictionary class]]) {
        
        NSString * key  = [[self class] fetchEncryptionKey];
        
        NSString * desparam = [param mj_JSONString];
        
        NSString *encryptParam   = [DESEncrypt encryptUseDES:desparam key:key];
        
        encryptParam =  [encryptParam stringByAppendingString:key];
        
        return encryptParam;
    
    }else if ([param isKindOfClass:[NSString class]]){
    
        NSString * key  = [[self class] fetchEncryptionKey];
        
        NSString * desparam = param;
        
        NSString *encryptParam   = [DESEncrypt encryptUseDES:desparam key:key];
        
        encryptParam =  [encryptParam stringByAppendingString:key];
        
        return encryptParam;
    
    }

    return param;

}

+(id)decryptionResponseData:(id)data url:(NSString*)url{

    if (![data isKindOfClass:[NSString class]]) {
        
        return data;
    }
    
    NSString * dataStr= data;

    if (dataStr.length>8) {
       
        NSString * dataStr = data ;
        
        NSString * key  = [dataStr substringFromIndex:dataStr.length-8];
        
        NSString * encryption = [dataStr substringToIndex:dataStr.length-8];
        
        
        return [DESEncrypt decryptUseDES:encryption key:key];
    }
    
    return data;
    
}

#pragma mark - 是否包含不加密的url
+(BOOL)isContainsWithNotDecryption:(NSString*)url{
  
    __block   BOOL isok = NO;
    
    [[[self class] arrContainsUrl] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString * containurl  = obj;
        
        if ([url containsString:containurl]) {
            
            isok = YES;
            
            *stop = YES;
        }
        
    }];
    
  return isok;
    
}

#pragma mark - 不加密的url
+(NSArray*)arrContainsUrl{

    return @[];
}


#pragma mark - 获取加密的随机key
+(NSString*)fetchEncryptionKey{
    
    
    NSString * stirng = @"";
    
    NSArray * arr = @[ @"A", @"B", @"C", @"D", @"E", @"F",
                       @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R",@"S",
                       @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"a", @"b", @"c", @"d", @"e", @"f",
                       @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s",
                       @"t", @"u", @"v", @"w", @"x", @"y", @"z", @"0", @"1", @"2", @"3", @"4", @"5",
                       @"6", @"7", @"8", @"9"];
    
    
    for (int  i= 0;i<8 ; i++) {
        
        int x =arc4random() %(arr.count);
        
        stirng = [stirng stringByAppendingString:arr[x]];
        
    }
    if (stirng.length==0) {
        
        stirng = @"123esdc";
    }
    
    return stirng;
}


@end
