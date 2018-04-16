//
//  OrderThreeTableViewCell.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/11/28.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "OrderThreeTableViewCell.h"

@implementation OrderThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    _cancelBtn.layer.borderWidth = 1;
    _cancelBtn.layer.borderColor = [UIColor colorWithHexString:@"c8c8ce"].CGColor;
    _cancelBtn.layer.cornerRadius = 3;
    
    _payBtn.layer.cornerRadius = 3;
}

@end
