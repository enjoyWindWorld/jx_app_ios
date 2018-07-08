//
//  JXPartnerEnumHeader.h
//  JXPartner
//
//  Created by windpc on 2017/8/11.
//  Copyright © 2017年 windpc. All rights reserved.
//

#ifndef JXPartnerEnumHeader_h
#define JXPartnerEnumHeader_h

typedef NS_ENUM(NSInteger,SPResetPwdType) {
    
    /** 忘记密码 */
    SPResetPwdType_ForgetPWD ,
    
    /** 注册设置密码 */
    SPResetPwdType_RegisiterPWD,
    
};

typedef NS_ENUM(NSInteger,JXPartnerLevel) {
    
    //ruitou
    JXPartnerLevel_AreaCounty = -1,
    
    JXPartnerLevel_ExperienceStores = -2,
    
    JXPartnerLeve_Partner = -3,
    //jx
    
    JXPartnerLevel_County = 0,    //分公司
    
    JXPartnerLevel_Province = 1,  //运营商
    
    JXPartnerLevel_City = 2,      //e创
    
//    JXPartnerLevel_Area = 3 ,

    
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


typedef NS_ENUM(NSInteger,SPAddorder_Type) {
    
    SPAddorder_Type_PAY,      //购买
    
    SPAddorder_Type_Renewal,  //续费
};

typedef NS_ENUM(NSInteger,ClarifierCostType){
    
    ClarifierCostType_YearFree,     //包年相关
    
    ClarifierCostType_TrafficFree , //流量相关
    
};

typedef NS_ENUM(NSInteger,AliBindingState){
    
    AliBindingState_Notbind,     //未绑定
    
    AliBindingState_Binded ,     //已绑定
    
};

typedef NS_ENUM(NSInteger,JXMessageState){
    
    JXMessageState_NotRead,     //未读
    
    JXMessageState_Readed ,     //已读
    
};

typedef NS_ENUM(NSInteger,Withdrawal_State){
    
    Withdrawal_State_Temporary       = -1,   //待提现
    
    Withdrawal_State_Initiate        = 0,    //提现发起
    
    Withdrawal_State_AuditFailere    = 1,    //审核失败
    
    Withdrawal_State_Cancle          = 2,    //取消
    
    Withdrawal_State_AuditSuccess    = 3,    //审核成功
    
    Withdrawal_State_Failere         = 4,    //提现失败
    
    Withdrawal_State_Success         = 200,   //提现成功
};




typedef NS_ENUM(NSInteger,JXMessageType){
    
//    0服务到期
//    1用户支付消息
//    2用户绑定消息
//    3机器分享
//    4用户解绑消息
//    5用户续费
//    6用户滤芯过期提醒
//    7提现发起
//    8审核成功
//    9审核失败
//    10提现成功
//    11提现失败
//    12上级审核消息
     /** 上级审核消息 */
    JXMessageType_SuperAdult = 12,
    
    JXMessageType_ChangeFree = 13 ,

};

typedef NS_ENUM(NSInteger,AfterSalesType) {

    AfterSalesType_ChangeFilter   = 1,

    AfterSalesType_ProductRepair  = 2,

    AfterSalesType_Others         = 3,

};


#endif /* JXPartnerEnumHeader_h */
