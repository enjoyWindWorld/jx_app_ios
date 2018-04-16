//
//  SPGoPayDetailPayTypeTableViewCell.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/21.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPGoPayDetailPayTypeTableViewCell.h"

@implementation SPHomeGoPayDeatailTableViewCell




@end


@implementation SPGoPayDetailPayTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setIsCheck:(BOOL)isCheck{

    if (isCheck) {
        //
        
        _isCheckIco.image = [UIImage imageNamed:@"CheckedBlue"];
        
    }else{
    
        _isCheckIco.image = [UIImage imageNamed:@"CheckNormal"];
        
    }
    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
