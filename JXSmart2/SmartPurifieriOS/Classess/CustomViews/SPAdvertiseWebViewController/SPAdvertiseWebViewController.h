//
//  SPAdvertiseWebViewController.h
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseViewController.h"
#import "SPBaseModel.h"

@interface SPWebContentModel : SPBaseModel

@property (nonatomic,copy)   NSString * url ;

@property (nonatomic,copy)  NSString * title ;

@end



@interface SPAdvertiseWebViewController : SPBaseViewController

@property (nonatomic,strong) SPWebContentModel * model ;

@end
