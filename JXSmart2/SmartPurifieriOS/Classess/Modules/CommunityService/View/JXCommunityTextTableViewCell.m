//
//  JXCommunityTextTableViewCell.m
//  SmartPurifieriOS
//
//  Created by Wind on 2017/6/24.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXCommunityTextTableViewCell.h"

@implementation JXCommunityTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _contentTextField.delegate = self;
    // Initialization code
}

-(void)textFieldDidEndEditing:(UITextField *)textField{

    if (_delegate && [_delegate respondsToSelector:@selector(cell_communityPushTextEndChange:text:)]) {
        
        [_delegate cell_communityPushTextEndChange:_indexpath text:textField.text];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
