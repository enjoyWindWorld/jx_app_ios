//
//  SPUserAddressListViewController.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/17.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseViewController.h"
@class spuserAddressListModel ;

@interface SPUserAddressListViewController : SPBaseViewController

@property (nonatomic,copy) void(^chooseAddressHandle)(spuserAddressListModel*model);

@end
