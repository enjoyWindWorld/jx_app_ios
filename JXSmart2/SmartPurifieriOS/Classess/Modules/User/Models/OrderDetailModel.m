//
//  OrderDetailModel.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/12.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation SPOrderDetailPriceModel

@end


@implementation OrderDetailModel

-(NSString*)fetchOrderStateDescription{
    
    NSInteger status = [self.status integerValue];
    
    switch (status) {
        case OrderState_NonPayment:
            
            return @"未支付";
            break;
            
        case OrderState_HadBeenPay:
            
            return @"已支付";
            break;
            
        case OrderState_HadCancel:
            
            return @"已取消";
            break;
            
        case OrderState_HadBinding:
            
            return @"已绑定";
            break;
            
        case OrderState_HadRenewMoney:
            
            return @"续费未使用";
            break;
            
        case OrderState_UseRenewMoney:
            
            return @"续费已使用";
            break;
            
        default:
            
            return @"未知";
            break;
    }
    
}

@end
