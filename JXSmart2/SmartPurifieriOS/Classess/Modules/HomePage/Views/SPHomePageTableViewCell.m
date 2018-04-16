//
//  SPHomePageTableViewCell.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPHomePageTableViewCell.h"
#import "SPHomePageListModel.h"
#import "SPSDWebImage.h"

@implementation SPHomePageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(SPHomePageListModel *)model{

    _model = model ;
    
    _titleName.text = model.name;
    
    _detailMoney.text = @"查看款式和价格";
    
    [SPSDWebImage SPImageView:_image imageWithURL:model.pic_url placeholderImage:[UIImage imageNamed:@"productplaceholderImage"]];
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
