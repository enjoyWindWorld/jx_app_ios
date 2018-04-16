//
//  MyClarifierWriteCostTableViewCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPClarifierTrafficModel.h"

@interface MyClarifierWriteCostTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIImageView *productICO;

@property (weak, nonatomic) IBOutlet UILabel *productName;


@property (weak, nonatomic) IBOutlet UILabel *productYearfree;


@property (weak, nonatomic) IBOutlet UILabel *productTrafficfree;


@property (weak, nonatomic) IBOutlet UIImageView *yearfreeICO;


@property (weak, nonatomic) IBOutlet UIImageView *trafficIco;


+(MyClarifierWriteCostTableViewCell*)tableView:(UITableView*)tableView CellWithIndex:(NSIndexPath*)indexPath itemModel:(SPClarifierWirtePayModel*)model;

+(CGFloat)tableView:(UITableView*)tableView heightForIndex:(NSIndexPath*)indexPath itemModel:(SPClarifierWirtePayModel*)model;

@end
