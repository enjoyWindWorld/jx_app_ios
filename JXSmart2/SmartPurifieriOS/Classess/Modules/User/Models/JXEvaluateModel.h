//
//  JXEvaluateModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/14.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"

@interface JXEvaluateModel : SPBaseModel

@property (nonatomic,copy) NSString * u_id ;
@property (nonatomic,copy) NSString * pro_no ;
@property (nonatomic,copy) NSString * ord_no ;
@property (nonatomic,copy) NSString * service_type ; //服务类型
@property (nonatomic,copy) NSString * service_master ; //服务师傅
@property (nonatomic,copy) NSString * service_master_phone ; //联系电话
@property (nonatomic,copy) NSString * ae_content ; //评价内容
@property (nonatomic,copy) NSString * appraise_url ; //评价url
@property (nonatomic,assign) NSInteger is_badge ; //工牌 0 没带 1带了
@property (nonatomic,assign) NSInteger is_overalls ; //工服 0 没带 1带了
@property (nonatomic,assign) NSInteger is_anonymous ; //匿名 0 没带 1带了
@property (nonatomic,copy) NSString * evaluation_people ; //联系人
@property (nonatomic,copy) NSString * evaluation_people_phnoe ;//联系方式
@property (nonatomic,assign) NSInteger  ae_satisfaction; //满意度 1-5
@property (nonatomic,assign) NSInteger  service_attitude; //服务态度 1-5
@property (nonatomic,copy) NSString * ae_addtime ;
@end
