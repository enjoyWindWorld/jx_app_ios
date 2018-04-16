//
//  JXAfterSalesViewController.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/3.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseViewController.h"
@class JXPlanFilterLifeModel;

@interface JXAfterSalesViewController : SPBaseViewController

@property (nonatomic,assign) NSInteger after_State ; // 1 进行 200 成功

@property (nonatomic,assign) BOOL  currentRepairList ;

@property (nonatomic,strong)   JXPlanFilterLifeModel * model  ;

@end
