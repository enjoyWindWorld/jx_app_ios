//
//  SPHomePageEnum.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/17.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#ifndef SPHomePageEnum_h
#define SPHomePageEnum_h
///枚举变量


/**
 净水器类别
 */
typedef NS_ENUM(NSInteger,SPpurifierType) {
   
    /** 壁挂式净水器 */
    SPpurifierTypeWall,
    /** 台式净水器 */
    SPpurifierTypeVertical,
    /** 立式净水器 */
    SPpurifierTypeDesktop,

};


typedef NS_ENUM(NSInteger,SP_AppPay_Type) {
    
    SP_AppPay_TypeNone , //预留
   
    SP_AppPay_TypeAli,  //阿里支付
    
    SP_AppPay_TypeWeChat, //微信
    
     SP_AppPay_TypeUnionpay, //银联
    
};

typedef NS_ENUM(NSInteger,SPAddorder_Type) {
    
    SPAddorder_Type_PAY,      //购买
    
    SPAddorder_Type_Renewal,  //续费
};

typedef NS_ENUM(NSInteger,SP_HomeDetailSectionType) {
    
     /** 净水器介绍 */
    SP_HomeDetailSectionType_IntroduceName ,
    
    SP_HomeDetailSectionType_TaskMoney,     //包年费用及流量使用说明
    
    SP_HomeDetailSectionType_ServicesName,  //服务说明
    
    SP_HomeDetailSectionType_ServicesP,     //服务承诺
};



#endif /* SPHomePageEnum_h */
