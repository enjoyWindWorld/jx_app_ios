//
//  MyClarifierDetailViewController.h
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXBaseTableViewController.h"
@class UserPurifierListModel;

@interface MyClarifierDetailViewController : JXBaseTableViewController

@property (nonatomic,strong) UserPurifierListModel * model;

@end
