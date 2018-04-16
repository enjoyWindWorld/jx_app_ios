//
//  JXAfterListTableViewCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/13.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXAfterListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cell_time;

@property (weak, nonatomic) IBOutlet UILabel *cell_type;

@property (weak, nonatomic) IBOutlet UILabel *cell_state;

@property (weak, nonatomic) IBOutlet UILabel *cell_content;

@end
