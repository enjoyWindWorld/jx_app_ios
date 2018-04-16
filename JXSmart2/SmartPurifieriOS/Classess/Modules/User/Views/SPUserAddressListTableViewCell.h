//
//  SPUserAddressListTableViewCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/29.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class spuserAddressListModel;

@protocol SPUserAddressListTableViewCellDelegate <NSObject>


-(void)cellModelWithState:(AddressCellActionState)state withModel:(spuserAddressListModel*)listmdoel ;

@end


@interface SPUserAddressListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIButton *defaultButton;

@property (weak, nonatomic) IBOutlet UIButton *changeButton;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (nonatomic,weak) id <SPUserAddressListTableViewCellDelegate>delegate ;

@property (nonatomic,strong) spuserAddressListModel * model ;

@end
