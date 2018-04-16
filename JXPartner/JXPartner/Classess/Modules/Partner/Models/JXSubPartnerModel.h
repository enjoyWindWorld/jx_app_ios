//
//  JXSubPartnerModel.h
//  JXPartner
//
//  Created by windpc on 2017/8/17.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "SPBaseModel.h"


@interface JXPartnerModel : SPBaseModel

@property (nonatomic,copy) NSString * par_id ;  //编号
@property (nonatomic,copy) NSString * par_name ; //名字
@property (nonatomic,assign) NSInteger par_level ; //级别

@property (nonatomic,copy) NSString * super_id ; //父级id
@property (nonatomic,copy) NSString * super_par_name ; //父级名称


//自定义的
@property (nonatomic,assign) NSInteger  permissions;

@end

@interface JXSubPartnerModel : SPBaseModel
//0  最高级
@property (nonatomic,assign) NSInteger  permissions;

@property (nonatomic,strong) NSArray * date ;


@end
