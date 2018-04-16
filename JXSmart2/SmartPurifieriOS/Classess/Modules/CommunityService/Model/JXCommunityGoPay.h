//
//  JXCommunityGoPay.h
//  SmartPurifieriOS
//
//  Created by Wind on 2017/6/24.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"

@interface JXCommunityGoPay : SPBaseModel

@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * ord_no;
@property (nonatomic,copy) NSString * seller;
@property (nonatomic,copy) NSString * pubid ;  //发布的ID
@property (nonatomic,assign) NSInteger isPush ;  //是否支付 0 支付版 1代表发布

@end
