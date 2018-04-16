//
//  spuserAddressListModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/29.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"

@interface spuserAddressListModel : SPBaseModel

@property (nonatomic,copy) NSString * addessid ;

@property (nonatomic,copy) NSString * area ;

@property (nonatomic,copy) NSString * phone;

@property (nonatomic,copy) NSString * detail;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,assign) BOOL  isdefault;

@end
