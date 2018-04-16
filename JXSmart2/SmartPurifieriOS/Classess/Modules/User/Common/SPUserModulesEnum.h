//
//  SPUserModulesEnum.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#ifndef SPUserModulesEnum_h
#define SPUserModulesEnum_h

typedef NS_ENUM(NSInteger,AddressCellActionState){

    AddressCellActionState_Default ,
    
    AddressCellActionState_Change ,
    
    AddressCellActionState_Delete ,

};

typedef NS_ENUM(NSInteger,MessageType){
    
    MessageType_Expire ,    //服务到期
    
    MessageType_Trade ,     //交易
    
    MessageType_Binding ,   //绑定
    
    MessageType_Share,      //分享
};

typedef NS_ENUM(NSInteger,OrderState){
    
     /** 未支付0 */
    OrderState_NonPayment,
     /** 已支付1 */
    OrderState_HadBeenPay,
     /** 已取消2 */
    OrderState_HadCancel,
     /** 已绑定3 */
    OrderState_HadBinding,
     /** 续费未使用4 */
    OrderState_HadRenewMoney,
     /** 续费已使用5 */
    OrderState_UseRenewMoney,
 
};


typedef NS_ENUM(NSInteger,ClarifierCostType){
    
    ClarifierCostType_YearFree,     //包年相关
    
    ClarifierCostType_TrafficFree , //流量相关
    
};

typedef NS_ENUM(NSInteger,ClarifierType) {

    ClarifierType_Mine,
    
    ClarifierType_Others
};

typedef NS_ENUM(NSInteger,AfterSalesType) {

    AfterSalesType_ChangeFilter   = 1,
    
    AfterSalesType_ProductRepair  = 2,
    
    AfterSalesType_Others         = 3,

};


#endif /* SPUserModulesEnum_h */
