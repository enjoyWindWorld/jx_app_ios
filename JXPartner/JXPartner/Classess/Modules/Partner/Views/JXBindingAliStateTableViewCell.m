//
//  JXBindingAliStateTableViewCell.m
//  JXPartner
//
//  Created by windpc on 2017/8/18.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXBindingAliStateTableViewCell.h"

@implementation JXBindingAliStateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _cellText.delegate = self ;
    // Initialization code
}


-(void)textFieldDidEndEditing:(UITextField *)textField{

    if (_delegate && [_delegate respondsToSelector:@selector(cell_BindingAliStatetTextChange:index:)]) {
        
        [_delegate cell_BindingAliStatetTextChange:textField.text index:_indexPath];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
