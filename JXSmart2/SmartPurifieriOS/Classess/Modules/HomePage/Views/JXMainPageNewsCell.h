//
//  JXMainPageNewsCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/24.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
@class JXMainPageModel;
#import "ADRollView.h"

@interface JXMainPageNewsCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet SDCycleScrollView *newsBanner;


@property (weak, nonatomic) IBOutlet ADRollView *newsContent;

@property (nonatomic,strong) JXMainPageModel * news;

@end
