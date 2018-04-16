//
//  SPClarifierTrafficModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"


@interface SPClarifierWirtePayModel : SPBaseModel

@property (nonatomic,copy) NSString * addressName ;

@property (nonatomic,copy) NSString * phone ;

@property (nonatomic,copy) NSString * detail;

@property (nonatomic,assign) ClarifierCostType type;

@property (nonatomic,copy) NSString * proname ;

@property (nonatomic,copy) NSString * proColor ;

@property (nonatomic,copy) NSString * prourl ;

@property (nonatomic,copy) NSString * yearfree ;

@property (nonatomic,copy) NSString * trafficfree ;

@end

//{"phone":"18617028072","ord_price":1500,"pro_invalidtime":1513419228000,"pro_hasflow":null,"pro_restflow":null,"pro_addtime":1481883228000,"name":null,"ph_no":"18617028072"}
@interface SPClarifierTrafficModel : SPBaseModel

@property (nonatomic,copy) NSString * productId ;

@property (nonatomic,copy) NSString * ord_no ;

@property (nonatomic,copy) NSString * name ;

@property (nonatomic,copy) NSString * phone ;

@property (nonatomic,copy) NSString * pro_no ;

@property (nonatomic,copy) NSString * ord_price ;

@property (nonatomic,copy) NSString * pro_addtime ;

@property (nonatomic,copy) NSString * pro_invalidtime ;

@property (nonatomic,copy) NSString * pro_hasflow ;

@property (nonatomic,copy) NSString * pro_restflow ;

@property (nonatomic,assign)NSInteger type ;

@property (nonatomic,copy) NSString* pro_name ;

@property (nonatomic,copy) NSString * ord_color ;

@property (nonatomic,assign) NSInteger sharetype ;








@property (nonatomic,copy) NSString * fetch_Time ;


@end
