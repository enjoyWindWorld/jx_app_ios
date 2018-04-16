//
//  SPWirtePayModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/29.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"
#import "SPPurifierModel.h"
#import "spuserAddressListModel.h"

@interface SPWirtePayModel : SPBaseModel

@property (nonatomic,copy) NSString * payTime;

@property (nonatomic,copy) NSString * payPmCode;

@property (nonatomic,strong) SPPurifierModel*payPurifierModel;

//地址model
@property (nonatomic,strong) spuserAddressListModel * addressModel ;

@end
