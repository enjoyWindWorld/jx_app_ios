//
//  MyOrderTableViewCell.h
//  SmartPurifieriOS
//
//  Created by Mray-mac on 2016/11/21.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UILabel *monenyLabel;

@end
