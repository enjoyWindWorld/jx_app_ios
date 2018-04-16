//
//  SPUserServiceHeaderView.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/17.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPUserModel ;

@interface SPUserServiceHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *userNickName;

@property (weak, nonatomic) IBOutlet UILabel *userDetail;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (nonatomic,strong) SPUserModel * userModel ;

@property (weak, nonatomic) IBOutlet UIButton *answer;

@property (weak, nonatomic) IBOutlet UIButton *shoppingcar;

@end
