//
//  JXPartnerModulesMacro.m
//  JXPartner
//
//  Created by windpc on 2017/8/16.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXPartnerModulesMacro.h"

@implementation JXPartnerModulesMacro

//获取信息
 NSString * const URL_FetchPartnerInformation = @"smvc/partner/logininformation.v";

//订单列表
 NSString * const  URL_FETCHPARTNERORDERLIST = @"smvc/partner/myOrders.v";

//订单详情
 NSString * const  URL_FETCHPARTNERORDERDETAIL =@"smvc/partner/orderuDetail.v";


//我的下属
 NSString * const URL_FETCHPARNERSUBLIST = @"smvc/partner/mystaff.v";

//我的下属订单列表
 NSString * const URL_FetchParnerSubOrderList = @"smvc/partner/mystaffdetails.v";

//绑定支付宝
 NSString * const URL_BindingAliAct = @"smvc/partner/bindingalipay.v";
//解绑支付宝
 NSString * const URL_UnBoodingAliAct = @"smvc/partner/unbundlingaccount.v";
//查看
 NSString * const URL_FetchAliInfo = @"smvc/partner/checkalipayinformation.v";

//查看消息列表
 NSString * const URL_FetchPartnerMessageList = @"smvc/partner/mymessage.v";
//删除消息
 NSString * const URL_FetchPartnerMessageDelete = @"smvc/partner/delmessage.v";
//修改状态为已读
 NSString * const URL_FetchPartnerMessageSetReaded = @"smvc/partner/updatemessage.v";
//统计数量
 NSString * const URL_FetchPartnerMessageListCount = @"smvc/partner/numberofmessage.v";


//提现money
 NSString * const URL_FetchTiXianMoney = @"smvc/partner/withdrawalamount.v";
//提现记录
 NSString * const URL_FetchTiXianHistory = @"smvc/partner/withdrawalrecord.v";
//提现发起
 NSString * const URL_FetchTiXianRequestAdd = @"smvc/partner/withdrawalorder.v";
//提现项
NSString * const URL_FetchTiXianItem = @"smvc/partner/salesamount.v";

//查看比例分别接口
 NSString * const URL_FetchParnerPermissions = @"smvc/partner/permissions.v";

//修改下属比例接口
 NSString * const URL_UpdatePartnerPermissions = @"smvc/partner/updatepermission.v";

//下级提现项
NSString * const URL_FetchSubTiXianDetail = @"smvc/partner/lowerdetails.v";

/** 上级审核下级体现单 */
 NSString * const URL_UpdateSubTiXianState = @"smvc/partner/withdrawalaudit.v";


+(NSString*)fetchParnerLevelString:(NSInteger)level{

    NSString * string = @"未知";
    
    switch (level) {
        case JXPartnerLevel_AreaCounty:
            
            string = @"区县代";
            
            break;
        case JXPartnerLevel_ExperienceStores:
            
            string = @"体验店";
            
            break;
            
        case JXPartnerLeve_Partner:
            
            string = @"合伙人";
            
            break ;
            
        case JXPartnerLevel_Province:
            
            string = @"省级";
            break ;
            
        case JXPartnerLevel_City:
            
            string = @"市级";
            break ;
            
        case JXPartnerLevel_Area:
            
            string = @"区级";
            break ;
            
        case JXPartnerLevel_County:
            string = @"产品经理";
            break ;
            
        default:
            break;
    }
    
    return string ;
}

+(NSInteger)fetchParnerLevelInter:(NSString*)level{

    NSInteger leve = 0 ;
    
    if ([level isEqualToString:@"产品经理"]) {
        
        leve = JXPartnerLevel_County;
    }
    if ([level isEqualToString:@"区级"]) {
        
        leve = JXPartnerLevel_Area;
    }
    if ([level isEqualToString:@"市级"]) {
        
        leve = JXPartnerLevel_City;
    }
    if ([level isEqualToString:@"省级"]) {
        
        leve = JXPartnerLevel_Province;
    }
    if ([level isEqualToString:@"合伙人"]) {
        leve = JXPartnerLeve_Partner;
        
    }
    if ([level isEqualToString:@"体验店"]) {
        
        leve = JXPartnerLevel_ExperienceStores;
    }
    if ([level isEqualToString:@"区县代"]) {
        
        leve = JXPartnerLevel_AreaCounty;
    }
    
    
    return leve ;
}

+(NSString*)fetchWithDrawal_State:(NSInteger)state{

    NSString * string = @"未知";
    
    switch (state) {
        case Withdrawal_State_Cancle:
            
            string = @"提现取消";
            
            break;
        case Withdrawal_State_Failere:
            
            string = @"提现失败";
            
            break;
            
        case Withdrawal_State_Success:
            
            string = @"提现成功";
            
            break ;
            
        case Withdrawal_State_Initiate:
            
            string = @"提现发起";
            break ;
            
        case Withdrawal_State_AuditFailere:
            
            string = @"审核失败";
            break ;
            
        case Withdrawal_State_AuditSuccess:
            
            string = @"审核成功";
            break ;
            
        default:
            break;
    }
    
    return string ;
}


#pragma mark - 售后模块
//套餐情况及滤芯情况统计
NSString * const URL_FetchPlanFilterLifeList = @"smvc/partner/filterofsetmeal.v";
//搜索接口
NSString * const URL_FetchPlanFilterSearchKeyWorld  = @"smvc/partner/search.v";
//滤芯警告接口
NSString * const URL_FetchFilterWarningList = @"smvc/partner/filterwarning.v";
//维修记录接口
NSString * const URL_FetchProductRepairList = @"smvc/partner/maintenancerecord.v";
//查看当前售后任务
NSString * const URL_FetchAfterSalesList = @"smvc/partner/afterthetask.v";
//查看某个详情
NSString * const URL_FetchAfterSalesDetails = @"smvc/partner/afterthetaskparticulars.v";
//合伙人查看评价
NSString * const URL_FetchAfterSalesPingJiaData = @"smvc/partner/partnerviewappraise.v";

+(NSString*)fetchProductDescWithType:(NSInteger)type{

    if (type == 1) {

        return @"壁挂式净水机";
    }else
    if (type == 2) {

        return @"台式净水机";
    }
    else
    {
        return @"立式净水机";
    }
}
@end
