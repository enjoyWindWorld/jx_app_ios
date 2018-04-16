//
//  SPAppPayManger.m
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/30.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPAppPayManger.h"
#import <AlipaySDK/AlipaySDK.h>
//#import "DataVerifier.h"
#import "Order.h"
//#import "DataSigner.h"
#import "WXApi.h"
#import "UPPaymentControl.h"


@implementation SPAppPayManger

+(instancetype)shareManger {
    
    static SPAppPayManger * manger = nil ;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manger = [[SPAppPayManger alloc] init];
        
        
    });

    return manger ;
}


+(void)spAppManger:(SP_AppPay_Type)type param:(id)param{

    switch (type) {
        case SP_AppPay_TypeAli:
            
        
            
           [[self class] privateOpenAliPay:param];
            
            break;
        case SP_AppPay_TypeWeChat:
            
            [[self class] privateOpenWeChatPay:param];
            break ;
            
        case SP_AppPay_TypeUnionpay:
            
            [[self class] privateOpenUnionPay:param];
        default:
            
            
            
            break;
    }
    
    [SPAppPayManger shareManger].infoPayType = type ;

}

+(void)privatePayCallBack:(NSDictionary*)resultDic type:(SP_AppPay_Type)type{
    
    switch (type) {
        case SP_AppPay_TypeAli:
            
            [[self class] privateAliPayCallBack:resultDic];
            
            break;
        case SP_AppPay_TypeWeChat:
            
            [[self class] privateWeChatPayCallBack:resultDic];
            
            break ;
            
        case SP_AppPay_TypeUnionpay:
            
            [[self class] privateUnionPayCallBack:resultDic];
            
            break ;
        
        default:
            
            
            break;
    }
    
     [SPAppPayManger shareManger].infoPayType = SP_AppPay_TypeNone ;
    
}

+(void)privateOpenAliPay:(id)param{
    
    if (param) {
        
        [[AlipaySDK defaultService] payOrder:param fromScheme:@"SmartPurifieriOS" callback:^(NSDictionary *resultDic) {
            
            
            [SPAppPayManger privatePayCallBack:resultDic type:SP_AppPay_TypeAli];
            
        }];
        
        return ;
    }

//    NSString *partner = @"2088521298136605";
//    
//    NSString *seller = @"szsjxzn@163.com"; //szsjxzn@163.com
//    
//    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAN5OVh1VucWVzbGS1LH0ytH6h9dlN/wvX4GZaMeIMkgZsZgBfF4V0eTUwhBfkSikhe1nV+4fR1Ss6Fo/9KA166ilNoE0F1EUwiXeVegGHNY7KYVTDJVT1iM6gqMPva7f/EWzpIW4G7/1NgsNEv/kN1CU5emS0OQDtc8er6xuCU7xAgMBAAECgYBnKNr1Se6nLdkB6i0hV4M25Zdb8PCF6kXbkiD5Vs5efu3Wp/nafy2jjsdvaammvpIXlLlNGt6zAHniR4NxRRRRlLr01Hhsn7FET6JFU6p/KM1/CxmoMbWbF+4obVVkmjIqLLHDTCjMraH/tlSrHT7xgvjiEw9Zk4yNzDBhyRUOsQJBAPVSJ4fDtDm1cZWFFjTBWQJB07R5ws6MoLOOv9nc7FQF7/O7rlm4cF4tOoXWSXClA02pHrMQZoOraeUZa2dBkucCQQDn+7RrzXVkcdoFntgH1qIy5/bovqJXyFdqWwTAQAhIXIXonkKgyUJnd/NxNpKKyX+8H2wxH16ZelcCcwSB7KxnAkB2fgsX+YBIy4okZVcXfjhm7bK7HoDo0WYhtJaYPaxs3T1MZd/N+FdWNdRpptpsLVgOH9zzMr3BZX9NqFyHUFYLAkAOXiWHg7sglHiXXoYsvhtfocRGGACABVV8rdR2f8DDko9sn9iqkqx9Mg2u1l1vIRm7MgsGY9X9FXmsGimOTnVDAkEAjON4g3oUF4hWAN5866iZ0OTnnDbZe7bS+3YOz7flggETyXlcom8/HUoyHhCQZ91EsFdgBwK6tQo2kSJ5LQHZTg==";
//    
//    
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.sellerID = seller;
//    order.outTradeNO = [[self class] generateTradeNO]; //订单ID（由商家自行制定）
//    order.subject = @"净喜"; //商品标题
//    order.body = @"净水器"; //商品描述
//    order.totalFee = @"0.01"; //商品价格
//    order.notifyURL =  @"http://www.xxx.com"; //回调URL
//    
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showURL = @"m.alipay.com";
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
////    id<DataSigner> signer = CreateRSADataSigner(privateKey);
////    NSString *signedString = [signer signString:orderSpec];
////
//    [[SPAppPayManger shareManger].hander importKeyWithType:KeyTypePrivate andkeyString:privateKey];
//    
//    NSString *signedString  = [[SPAppPayManger shareManger].hander signString:orderSpec];
////    
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//    }
//////    9000	订单支付成功
//////    8000	正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
//////    4000	订单支付失败
//////    5000	重复请求
//////    6001	用户中途取消
//////    6002	网络连接出错
//////    6004	支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
//    [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"SmartPurifieriOS" callback:^(NSDictionary *resultDic) {
//        
//        
//        [SPAppPayManger privatePayCallBack:resultDic type:SP_AppPay_TypeAli];
//        
//    }];
//
    
}

+(void)privateOpenWeChatPay:(id)param{
    

    NSMutableString *stamp  = [param objectForKey:@"timestamp"];
    
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
   
    req.partnerId           = [param objectForKey:@"partnerid"];
    
    req.prepayId            = [param objectForKey:@"prepayid"];
    
    req.nonceStr            = [param objectForKey:@"noncestr"];
    
    req.timeStamp           = stamp.intValue;
    
    req.package             = [param objectForKey:@"package"];
    
    req.sign                = [param objectForKey:@"sign"];
    
    [WXApi sendReq:req];

}

+(void)privateOpenUnionPay:(id)param{
    
    
    //[[UPPaymentControl defaultControl] startPay:@"680729288516230176500" fromScheme:@"SmartPurifieriOS" mode:@"00" viewController:nil];
    

    
}


#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
  
    if([resp isKindOfClass:[PayResp class]]){
       
        [SPAppPayManger shareManger].infoPayType = SP_AppPay_TypeNone ;
        
        BOOL isok = NO ;
        
        NSString * mesg = nil;
        
        //    WXErrCodeCommon     = -1,   /**< 普通错误类型    */
        //    WXErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
        //    WXErrCodeSentFail   = -3,   /**< 发送失败    */
        //    WXErrCodeAuthDeny   = -4,   /**< 授权失败    */
        //    WXErrCodeUnsupport  = -5,   /**< 微信不支持    */
        
        switch (resp.errCode) {
            case WXSuccess:
                
                isok = YES;
                
                mesg = @"支付成功!";
                
                break;
                
            case WXErrCodeUserCancel:
                
                mesg = @"用户点击取消并返回";
                
                break ;
                
            case WXErrCodeSentFail:
                
                mesg = @"发送失败 ";
                
                break ;
                
            case WXErrCodeAuthDeny:
                
                mesg = @"授权失败";
                
                break ;
                
            case WXErrCodeUnsupport:
                mesg  = @"微信不支持";
                
                break ;
                
            default:
                
                mesg = [NSString stringWithFormat:@"%@",@"普通错误类型"];
                
                break;
        }
        
         [[NSNotificationCenter defaultCenter] postNotificationName:SPElectricityPayResult object:nil userInfo:@{@"result":[NSNumber numberWithInteger:isok],@"message":mesg}];
    }
    
}


+(void)privateAliPayCallBack:(NSDictionary*)resultDic{

    BOOL isok = NO ;
    
    NSString * message = @"订单支付失败";
    
    if (![resultDic  isEqual:[NSNull null]] && resultDic) {
        
    
        
        NSInteger resultCode  =  [[resultDic objectForKey:@"resultStatus"] integerValue] ;
        
        
        if (resultCode == 9000) {
            
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[[resultDic objectForKey:@"result"] mj_JSONObject] options:NSJSONWritingPrettyPrinted error:nil];
            
            NSString * resultString  =[resultDic objectForKey:@"result"];
            
            NSLog(@"resultString  %@",resultString);
            //验签
            NSString * orderStr = [resultString componentsSeparatedByString:@"&success="][0];
           
            NSString *signStr =[resultString componentsSeparatedByString:@"&sign="][1];
           
//            NSInteger length =signStr.length;
          
            //解签
            if ( [[self class] UnEncryptionOrderString:orderStr sign:signStr]) {
                
                isok = YES;
                
                message = @"订单支付成功";
                
                NSLog(@"支付成功了");
            }else{
            
                 isok = NO;
                message = @"订单支付失败";
                
                NSLog(@"支付失败了");
            }

        }
        else{
            isok = NO ;
            
            if (resultCode==6001) {
                
                message = @"用户取消操作";
            }else if (resultCode==5000) {
                    
                message = @"重复操作";
            }else if (resultCode == 6002){
            
                message = @"网络连接出错";
            }else if (resultCode == 8000){
                
                message = @"正在处理中";
            }else{
            
                message = @"订单支付失败";
            }
            
        }
    }
    
    //订单号？ out_trade_no
    [[NSNotificationCenter defaultCenter] postNotificationName:SPElectricityPayResult object:nil userInfo:@{@"result":[NSNumber numberWithInteger:isok],@"message":message}];
}


+(void)privateWeChatPayCallBack:(NSDictionary*)resultDic{

//只为 none
    BOOL isok = NO ;
    
    NSString * message = @"订单支付失败";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SPElectricityPayResult object:nil userInfo:@{@"result":[NSNumber numberWithInteger:isok],@"message":message}];
}

+(void)privateUnionPayCallBack:(NSDictionary*)resultDic{
    
    //只为 none
    BOOL isok = [resultDic objectForKey:@"result"] ;
    

    NSString * message = isok==YES?@"订单支付成功":@"订单支付失败";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SPElectricityPayResult object:nil userInfo:@{@"result":[NSNumber numberWithBool:isok],@"message":message}];
}

+(BOOL)UnEncryptionOrderString:(NSString*)orderString sign:(NSString*)asign{

    return YES ;
    
    if (asign.length==0 || [asign isEqual:[NSNull null]]) {
        
        return NO;
    }

    [[SPAppPayManger shareManger].hander importKeyWithType:KeyTypePublic andPath:[[NSBundle mainBundle] pathForResource:@"rsa_public_key.pem" ofType:nil]];
    
    BOOL result = [[SPAppPayManger shareManger].hander verifyString:orderString withSign:asign];
    
    return result ;
}


-(HBRSAHandler *)hander{

    if (_hander == nil) {
        
        _hander = [HBRSAHandler new];
    }
    return _hander;
}


+ (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
