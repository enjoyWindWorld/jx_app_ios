//
//  SPAppPayManger.h
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/30.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseBusiness.h"
#import "HBRSAHandler.h"
#import "WXApi.h"

@interface SPAppPayManger : SPBaseBusiness<WXApiDelegate>

@property (nonatomic,assign) SP_AppPay_Type infoPayType ;

@property (nonatomic,strong) HBRSAHandler * hander ;


+(instancetype)shareManger ;


+(void)spAppManger:(SP_AppPay_Type)type param:(id)param;


//查询



+(void)privatePayCallBack:(NSDictionary*)resultDic type:(SP_AppPay_Type)type;



@end
