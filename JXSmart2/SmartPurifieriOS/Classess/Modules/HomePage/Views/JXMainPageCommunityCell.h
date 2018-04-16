//
//  JXMainPageCommunityCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/24.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXMainAdvModel;
@interface JXMainPageCommunityCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ico;

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic,strong) JXMainAdvModel * pageModel ;


@end
