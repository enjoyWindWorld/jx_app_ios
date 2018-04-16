//
//  JXWritePayAddressCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/8.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>


@class spuserAddressListModel;
@interface JXWritePayAddressCell : UITableViewCell

@property (nonatomic,strong) spuserAddressListModel * addressModel ;


@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
