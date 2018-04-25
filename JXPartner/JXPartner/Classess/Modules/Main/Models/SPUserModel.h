//
//  SPUserModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/28.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"

//用户模型
@interface SPUserModel : SPBaseModel

@property (nonatomic,copy)      NSString  *   partnerNumber ; //编号
@property (nonatomic,copy)      NSString  *   username ;    //名字
@property (nonatomic,assign)     NSInteger  level ;       //级别
@property (nonatomic,copy)      NSString * ParParentName ;   //父
@property (nonatomic,copy)      NSString * ParParentid ;     //父
@property (nonatomic,assign)    BOOL originalpassword ;   //默认密码
@property (nonatomic,assign)    BOOL  unboundedalipay ;   //没绑定
@property (nonatomic,assign)    NSInteger  usernum ; //销售数量

@property (nonatomic,copy) NSString * safetyMark ;  //标示

@property (nonatomic,assign) NSTimeInterval timeout;
@property (nonatomic,assign) NSInteger operatorInter ;


-(BOOL)saveCurrentPartnerModel;

+(BOOL)delCurrentPartnerModel;

+(SPUserModel*)fetchPartnerModelDF;


@end
