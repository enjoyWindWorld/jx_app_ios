//
//  MyClarifierMessageTableViewCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyClarifierMessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *messageLogo;

@property (weak, nonatomic) IBOutlet UIImageView *messageIsRead;

@property (weak, nonatomic) IBOutlet UILabel *messageTitle;

@property (weak, nonatomic) IBOutlet UILabel *messageTime;

@property (weak, nonatomic) IBOutlet UILabel *messageContent;

@end
