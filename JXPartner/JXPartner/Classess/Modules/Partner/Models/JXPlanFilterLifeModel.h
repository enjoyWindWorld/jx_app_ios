//
//  JXPlanFilterLifeModel.h
//  JXPartner
//
//  Created by windpc on 2017/11/14.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "SPBaseModel.h"

#define PLAN_FILTER_LEFTTITLE @"PLAN_FILTER_LEFTTITLE"
#define PLAN_FILTER_RIGHTTITLE @"PLAN_FILTER_RIGHTTITLE"


@interface JXPlanFilterLifeModel : SPBaseModel

@property (nonatomic,copy) NSString * ord_receivename ;
@property (nonatomic,copy) NSString * ord_phone ;
@property (nonatomic,copy) NSString * adr_id ;
@property (nonatomic,copy) NSString * ord_protypeid ;
@property (nonatomic,assign) CGFloat pro_restflow ;  //剩余流量
@property (nonatomic,assign) CGFloat pro_day ;  //剩余天数
@property (nonatomic,copy) NSString * pro_no ;
@property (nonatomic,copy) NSString * color ;
@property (nonatomic,copy) NSString * pro_id ;
@property (nonatomic,copy) NSString * ord_managerno ;
@property (nonatomic,copy) NSString * ord_no ;
@property (nonatomic,copy) NSString * name ;
@property (nonatomic,copy) NSString * url ;
@property (nonatomic,copy) NSString * pro_alias ;
@property (nonatomic,strong) NSArray * Filter_state ;

@property (nonatomic,strong) NSArray * viewItemArr ;  //寿命统计

@property (nonatomic,strong) NSArray * filterWarningViewItemArr ; //滤芯警告


@end
