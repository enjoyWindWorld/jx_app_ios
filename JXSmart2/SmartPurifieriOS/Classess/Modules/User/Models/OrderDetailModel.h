//
//  OrderDetailModel.h
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/12.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPBaseModel.h"

@interface SPOrderDetailPriceModel : SPBaseModel

@property (nonatomic,assign) NSInteger paytype ;

@property (nonatomic,copy) NSString * price ;

@end


@interface OrderDetailModel : SPBaseModel
@property (nonatomic,copy) NSString *ordNo;
@property (nonatomic,copy) NSString *uname;

@property (nonatomic,copy) NSString *way;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *serttime;
@property (nonatomic,assign) CGFloat price;
@property (nonatomic,copy) NSString *status;

@property (nonatomic,assign)NSInteger paytype ;

@property (nonatomic,copy) NSString * url ;
@property (nonatomic,copy) NSString * color ;
//是否续费订单
@property (nonatomic,assign) NSInteger isagain ;

@property (nonatomic,strong) NSArray * priceArr ;

@property (nonatomic,copy) NSString * tag ;


@property (nonatomic,copy) NSString * ord_modtime ;

-(NSString*)fetchOrderStateDescription;

@end
