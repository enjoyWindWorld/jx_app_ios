//
//  NSString+Verification.m
//  XHApp
//
//  Created by 肖会军 on 16/3/19.
//  Copyright © 2016年 刘军林. All rights reserved.
//

#import "NSString+Verification.h"

@implementation NSString (Verification)


/**
 验证手机号
 
 @return YES NO
 */
-(BOOL)predicateStringWithPhone{

    BOOL isOk  = YES;;
    
    NSString *regex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![pred evaluateWithObject:self]) {
        
        isOk = NO;
        
    }
    /**
     *  香港手机长度
     */
    if (self.length==8) {
      
        isOk = YES;
        
    }

    return isOk;
}



/**
 验证密码
 
 @return YES NO
 */
-(BOOL)predicateStringWithPassword{
    
    BOOL isOk  = YES;;
//    不能全部为数字
//    不能全部为字母
//    必须包含字母和数字
//    6-16位
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![pred evaluateWithObject:self]) {
        
        isOk = NO;
        
    }


    return isOk;
}


- (NSString*) urlEncodedString {
    
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
    
    return encodedString;
}

- (NSString*) urlDecodedString {
    
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef) self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}


@end
