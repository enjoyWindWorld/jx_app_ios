//
//  JXProductGroupCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/6.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXShoppingCarModel;

@interface JXProductGroupCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *group_ico;

@property (weak, nonatomic) IBOutlet UILabel *group_name;

@property (weak, nonatomic) IBOutlet UILabel *group_cost_ppdnum;

@property (weak, nonatomic) IBOutlet UILabel *group_color;

@property (weak, nonatomic) IBOutlet UILabel *group_price;

@property (weak, nonatomic) IBOutlet UILabel *group_number;

@property (nonatomic,strong) JXShoppingCarModel * model ;


@end
