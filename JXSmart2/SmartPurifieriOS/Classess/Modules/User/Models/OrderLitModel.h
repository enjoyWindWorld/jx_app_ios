//
//  OrderLitModel.h
//  SmartPurifieriOS
//
//  Created by yuan on 2016/11/29.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPBaseModel.h"
@interface OrderLitModel : SPBaseModel
@property (nonatomic,copy) NSString *addtime;
@property (nonatomic,copy) NSString *ordno;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *status;


@property (nonatomic,copy) NSString *dateClassHeader;

-(NSString*)fetchOrderStateDescription;



@end
