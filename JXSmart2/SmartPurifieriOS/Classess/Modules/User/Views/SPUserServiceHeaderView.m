//
//  SPUserServiceHeaderView.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/17.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPUserServiceHeaderView.h"
#import "SPUserModel.h"


@implementation SPUserServiceHeaderView

-(void)awakeFromNib{

    [super awakeFromNib];

}

-(void)setUserModel:(SPUserModel *)userModel{
    
    _userModel = userModel ;
    
    _userNickName.text = userModel.nickname ;
    
    [SPSDWebImage SPImageView:_userImage imageWithURL:userModel.userImg placeholderImage:[UIImage imageNamed:SPUSERHEADICOIMAGESTR]];

  
    _userDetail.text = userModel.sign;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
