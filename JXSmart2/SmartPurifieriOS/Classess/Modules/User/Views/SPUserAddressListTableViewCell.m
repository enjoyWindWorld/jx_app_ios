//
//  SPUserAddressListTableViewCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/29.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPUserAddressListTableViewCell.h"
#import "spuserAddressListModel.h"

@implementation SPUserAddressListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.defaultButton addTarget:self action:@selector(cellButtonClickWithDefault) forControlEvents:UIControlEventTouchUpInside];
    [self.changeButton addTarget:self action:@selector(cellButtonClickWithChange) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteButton addTarget:self action:@selector(cellButtonClickWithDelete) forControlEvents:UIControlEventTouchUpInside];

    
    // Initialization code
}

-(void)setModel:(spuserAddressListModel *)model{
    
    _model = model;
    
    _nameLabel.text = model.name ;
    
    _phoneLabel.text = model.phone ;
    
    _addressLabel.text = [NSString stringWithFormat:@"%@%@",model.area,model.detail] ;
    
    if (!model.isdefault) {
        
        _defaultButton.selected = YES ;
        
    }else{
    
        _defaultButton.selected = NO ;
    }

}

#pragma mark - 点击设置默认
-(void)cellButtonClickWithDefault{
    
    if (_delegate && [_delegate respondsToSelector:@selector(cellModelWithState:withModel:)]) {
        
        [_delegate cellModelWithState:AddressCellActionState_Default withModel:_model];
    }
    
    
}
#pragma mark - 点击修改
-(void)cellButtonClickWithChange{
    
    if (_delegate && [_delegate respondsToSelector:@selector(cellModelWithState:withModel:)]) {
        
         [_delegate cellModelWithState:AddressCellActionState_Change withModel:_model];
    }
    
}
#pragma mark - 点击删除
-(void)cellButtonClickWithDelete{
    
    if (_delegate && [_delegate respondsToSelector:@selector(cellModelWithState:withModel:)]) {
        
         [_delegate cellModelWithState:AddressCellActionState_Delete withModel:_model];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
