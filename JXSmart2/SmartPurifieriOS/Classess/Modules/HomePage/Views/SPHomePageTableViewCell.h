//
//  SPHomePageTableViewCell.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPHomePageListModel ;

@interface SPHomePageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleName;

@property (weak, nonatomic) IBOutlet UILabel *detailMoney;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (nonatomic,strong) SPHomePageListModel * model ;

@end
