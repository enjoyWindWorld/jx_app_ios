//
//  SPWirtePayModel.m
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/29.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPWirtePayModel.h"

@implementation SPWirtePayModel

-(NSString *)payTime{
    
    if (_payTime.length ==0) {
        
        return @"选择安装时间";
    }
    return _payTime ;
}

//-(NSString *)payPhone
//{
//    if (_payPhone.length==11)
//    {
//        NSMutableString *mobile = [NSMutableString stringWithString:_payPhone];
//        
//        [mobile replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
//        
//        return mobile;
//        
//    }
//    
//    if (_payPhone.length ==0) {
//        
//        return @"暂无";
//    }
//    return _payPhone;
//}

@end
