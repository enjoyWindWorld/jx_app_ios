//
//  JXPartnerOrderListTableViewCell.h
//  JXPartner
//
//  Created by windpc on 2017/8/16.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXPartnerOrderListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ordersnLabel;

@property (weak, nonatomic) IBOutlet UILabel *ordernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *ordertimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderstateLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderpriceLabel;

@end
