//
//  JXPlanFilterLifeModel.m
//  JXPartner
//
//  Created by windpc on 2017/11/14.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXPlanFilterLifeModel.h"
#import "JXFitlerModel.h"
#import "JXPartnerModulesMacro.h"

@implementation JXPlanFilterLifeModel

+(NSDictionary *)mj_objectClassInArray{

    return @{@"Filter_state":[JXFitlerModel class]};

}

-(NSArray *)viewItemArr{

    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
    
    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"客户名字:",PLAN_FILTER_RIGHTTITLE:self.ord_receivename}];
    
    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"联系方式:",PLAN_FILTER_RIGHTTITLE:self.ord_phone}];
    
    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"订单号:",PLAN_FILTER_RIGHTTITLE:self.ord_no}];

    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"家庭地址:",PLAN_FILTER_RIGHTTITLE:self.adr_id}];

    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"净水器编号:",PLAN_FILTER_RIGHTTITLE:self.pro_no}];


    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"净水器类型:",PLAN_FILTER_RIGHTTITLE:[JXPartnerModulesMacro fetchProductDescWithType:[self.pro_id integerValue]]}];

    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"包年时间剩余:",PLAN_FILTER_RIGHTTITLE:[NSString stringWithFormat:@"%d天",(int)self.pro_day]}];

    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"流量套餐剩余:",PLAN_FILTER_RIGHTTITLE:[NSString stringWithFormat:@"%d升",(int)self.pro_restflow]}];

    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"滤芯状况",PLAN_FILTER_RIGHTTITLE:@""}];

    return  arr ;
}

-(NSArray *)filterWarningViewItemArr{

    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];

    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"客户名字:",PLAN_FILTER_RIGHTTITLE:self.ord_receivename}];

    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"联系方式:",PLAN_FILTER_RIGHTTITLE:self.ord_phone}];

    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"订单号:",PLAN_FILTER_RIGHTTITLE:self.ord_no}];

    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"家庭地址:",PLAN_FILTER_RIGHTTITLE:self.adr_id}];

    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"净水器编号:",PLAN_FILTER_RIGHTTITLE:self.pro_no}];

    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"净水器类型:",PLAN_FILTER_RIGHTTITLE:[JXPartnerModulesMacro fetchProductDescWithType:[self.pro_id integerValue]]}];

    [arr addObject:@{PLAN_FILTER_LEFTTITLE:@"滤芯状况",PLAN_FILTER_RIGHTTITLE:@""}];

    return  arr ;
}
@end
