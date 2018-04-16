//
//  JXNewAfterSalesViewController.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/3.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseViewController.h"
@class JXAfterListModel;

@interface JXNewAfterSalesViewController : SPBaseViewController

@property (nonatomic,assign) AfterSalesType  afterSalesType ;

@property (nonatomic,strong) JXAfterListModel * model ;

@end
