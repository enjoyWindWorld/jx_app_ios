//
//  JXWritePayAddressCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/8.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXWritePayAddressCell.h"
#import "spuserAddressListModel.h"

@implementation JXWritePayAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setAddressModel:(spuserAddressListModel *)addressModel{

    _addressModel = addressModel;
    
    [self configcellWith:addressModel];
}

-(void)configcellWith:(spuserAddressListModel*)model{
    
    if (!model) {
        
        self.addressLabel.text = @"选择家庭地址";
        
    }else{
        
        NSString * name = model.name ;
        
        NSString * phone = model.phone ;
        
        NSString * area = model.area ;
        
        NSString * detail = model.detail ;
        
        NSString * address  = [NSString stringWithFormat:@"%@    %@\n%@%@",name,phone,area,detail];
        
        NSRange range = [address rangeOfString:[NSString stringWithFormat:@"%@    %@",name,phone]];
        
        NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc] initWithString:address];
        
        NSMutableParagraphStyle   *paragraphStyle   = [[NSMutableParagraphStyle alloc] init];
        //行间距
        [paragraphStyle setLineSpacing:5.0];
        
        [attstr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, address.length)];
        
        [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:range];
        
        range = [address rangeOfString:[NSString stringWithFormat:@"%@%@",area,detail]];
        
        [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
        
        [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"777777"] range:range];
        
        self.addressLabel.attributedText = attstr;
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
