//
//  MyClarifierTableViewCell.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/11/22.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "MyClarifierTableViewCell.h"

@implementation MyClarifierTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _cellImg.layer.masksToBounds = YES;
    
    _cellImg.layer.cornerRadius = _cellImg.frame.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
