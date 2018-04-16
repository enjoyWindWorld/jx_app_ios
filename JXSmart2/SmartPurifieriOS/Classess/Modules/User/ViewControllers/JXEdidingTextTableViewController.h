//
//  JXEdidingTextTableViewController.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/10.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXBaseTableViewController.h"



typedef void(^ComplationBlock)(NSString * text,NSIndexPath * index);

@interface JXEdidingTextTableViewController : JXBaseTableViewController

@property (nonatomic,copy) ComplationBlock complationBlock ;

@property (nonatomic,strong) NSIndexPath * indexPath ;

@property (nonatomic,copy) NSString * defaultString ;

@property (nonatomic,assign) UIKeyboardType type ;

@end
