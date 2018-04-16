//
//  JXShoppingItemTableViewCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/16.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXShoppingItemTableViewCell.h"
#import "JXShoppingCarModel.h"

@implementation JXShoppingItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _countNumber.delegate = self;
    
    _countNumber.tintColor = HEXCOLOR(@"999999");
    
    _countNumber.textField.textColor = HEXCOLOR(@"999999");
//    _countNumber.maxValue = 3;
    
    [_selectBtn addTarget:self action:@selector(productitemSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    _nameLabel.adjustsFontSizeToFitWidth = YES;
    _priceLabel.adjustsFontSizeToFitWidth = YES;
}


-(void)setModel:(id)model{

    if ([model isKindOfClass:[JXShoppingCarModel  class]]) {
        
        JXShoppingCarModel * itemModel = model;
        
        [SPSDWebImage SPImageView:_ico imageWithURL:itemModel.url placeholderImage:[UIImage imageNamed:SPPRODUCTICOPLACEHOLDERImage]];
        
        _nameLabel.text = [NSString stringWithFormat:@"%@(%@)",itemModel.name,itemModel.color];
        
        _countLabel.text = [NSString stringWithFormat:@"x%ld",itemModel.number];
       
        _countNumber.currentNumber = itemModel.number;
        
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",itemModel.totalPrice];
        
        _costTypeLabel.text = itemModel.yearsorflow;
    }
    
    

}

-(void)productitemSelect:(UIButton*)btn{

    if (_delegate && [_delegate  respondsToSelector:@selector(shopcar_selectBtnChange:select:)]) {
        
        [_delegate shopcar_selectBtnChange:_index select:btn.isSelected];
    }
    
}

-(void)pp_numberButton:(__kindof UIView *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus{

    if (_delegate && [_delegate respondsToSelector:@selector(shopcar_numberButtnChange:number:)]) {
        
        [_delegate shopcar_numberButtnChange:_index number:number];
    }

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
