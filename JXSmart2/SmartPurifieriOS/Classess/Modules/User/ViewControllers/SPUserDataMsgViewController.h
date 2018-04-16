//
//  SPUserDataMsgViewController.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/17.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXBaseTableViewController.h"

/**
 个人信息
 */
@interface SPUserDataMsgViewController : JXBaseTableViewController
@property (nonatomic,retain) NSString *value;
@property (nonatomic,retain) NSString *nickname;
@property (nonatomic,retain) NSString *Sign;

@end
