//
//  JXChooseProductTableViewCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/6.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXChooseProductTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pro_ico;

@property (weak, nonatomic) IBOutlet UILabel *pro_name;

@property (weak, nonatomic) IBOutlet UILabel *pro_color;
@property (weak, nonatomic) IBOutlet UILabel *pro_order;

@property (weak, nonatomic) IBOutlet UILabel *pro_idcard;
@end
