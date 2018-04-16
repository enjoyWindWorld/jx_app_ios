//
//  JXCommunityShopDetailTableViewCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/27.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ServiceModel;
@interface JXCommunityShopDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *shop_name;

@property (weak, nonatomic) IBOutlet UILabel *shop_address;

@property (weak, nonatomic) IBOutlet UIButton *location;

@property (weak, nonatomic) IBOutlet UIButton *time;

@property (nonatomic,strong) ServiceModel * model ;

@end
