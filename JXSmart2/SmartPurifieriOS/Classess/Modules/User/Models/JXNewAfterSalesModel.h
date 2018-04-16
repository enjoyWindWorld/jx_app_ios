//
//  JXNewAfterSalesModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/7.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"

@interface JXNewAfterSalesModel : SPBaseModel

@property (nonatomic,copy) NSString * dataIdentifier ;
@property (nonatomic,copy) NSString * pro_id ;
@property (nonatomic,copy) NSString * u_id ;
@property (nonatomic,copy) NSString * ord_color;
@property (nonatomic,copy) NSString * ord_no ;
@property (nonatomic,copy) NSString * pro_no;
@property (nonatomic,copy) NSString * pro_name;
@property (nonatomic,copy) NSString * proflt_life ;
@property (nonatomic,copy) NSString * filter_name ;
@property (nonatomic,copy) NSString * make_time ;
@property (nonatomic,copy) NSString * contact_person ;
@property (nonatomic,copy) NSString * contact_way;
@property (nonatomic,copy) NSString * user_address;
@property (nonatomic,copy) NSString * address_details;
@property (nonatomic,copy) NSString * fault_cause ;
@property (nonatomic,copy) NSString * specific_reason ;
@property (nonatomic,copy) NSString * fautl_url ;
@property (nonatomic,copy) NSString * ord_managerno;
@property (nonatomic,assign) NSInteger fas_state;
@property (nonatomic,assign) NSInteger fas_type ;
@property (nonatomic,copy) NSString * fas_addtime ;
@property (nonatomic,copy) NSString * fas_modtime ;


@end
