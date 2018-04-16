//
//  SPWritePayTableViewCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/29.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPWirtePayModel;

@interface SPWritePayTableViewCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UILabel * chooseAddressLabel ;

@property (weak, nonatomic) IBOutlet UILabel *chooseTimeLabel;

@property (weak, nonatomic) IBOutlet UITextField *choosePMText;

@property (weak, nonatomic) IBOutlet UILabel *chooseMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *chooseMoneyType;



@property (weak, nonatomic) IBOutlet UIImageView *choosePDICO;

@property (weak, nonatomic) IBOutlet UILabel *choosrPDName;

@property (weak, nonatomic) IBOutlet UILabel *choosePDCost;


+(SPWritePayTableViewCell*)tableView:(UITableView*)tableView CellWithIndex:(NSIndexPath*)indexPath itemModel:(SPWirtePayModel*)model;

+(CGFloat)tableView:(UITableView*)tableView heightForIndex:(NSIndexPath*)indexPath itemModel:(SPWirtePayModel*)model;


@end
