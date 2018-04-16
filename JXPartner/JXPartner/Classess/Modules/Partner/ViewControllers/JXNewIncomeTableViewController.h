//
//  JXNewIncomeTableViewController.h
//  JXPartner
//
//  Created by windpc on 2017/8/24.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXBaseTableViewController.h"
@class JXSubCurrentModel;

@interface JXNewIncomeTableViewController : JXBaseTableViewController

@property (nonatomic,copy) NSString * walletOrdersn ;

@property (nonatomic,copy) NSString * defaultMoney ;

@property (nonatomic,assign) BOOL  isAdult ;

@property (nonatomic,strong) JXSubCurrentModel * subModel ;

@end
