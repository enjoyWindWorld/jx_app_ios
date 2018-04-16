//
//  SPAddOrderModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/10.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"




@interface SPAddOrderModel : SPBaseModel

@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * ord_no;
@property (nonatomic, copy) NSString *context;
@property (nonatomic,copy)  NSString * tag ;
@property (nonatomic,assign) NSInteger paytype ;

@property (nonatomic,assign) SPAddorder_Type type ;

@end
