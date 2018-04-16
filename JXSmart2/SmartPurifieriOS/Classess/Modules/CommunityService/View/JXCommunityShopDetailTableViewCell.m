//
//  JXCommunityShopDetailTableViewCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/27.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXCommunityShopDetailTableViewCell.h"
#import "ServiceModel.h"
#import "UIButton+WEdgeInSets.h"

@implementation JXCommunityShopDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ServiceModel *)model{

    _model = model ;
    
    _shop_name.adjustsFontSizeToFitWidth = YES;
    
    CGFloat distance = [model.distance floatValue];
    
    _location.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    if (distance >10*1000) {
        
        distance = distance / 1000 ;
    
        [_location setTitle:[NSString stringWithFormat:@"大约%.2f千米",distance] forState:UIControlStateNormal];
    }else{
    
        [_location setTitle:[NSString stringWithFormat:@"大约%ld米",(NSInteger)distance] forState:UIControlStateNormal];
    }
    
    
    [_time setTitle:[NSString stringWithFormat:@"%@ ~ %@",model.vaildtime,model.invildtime] forState:UIControlStateNormal];
    
    [_time layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsImageStyleLeft imageTitlespace:5];
    
    [_location layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsImageStyleLeft imageTitlespace:5];
    
    _shop_name.text = model.name;
    
    _shop_address.text = model.address;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
