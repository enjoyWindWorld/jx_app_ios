//
//  JXCommunityBannerCell.h
//  SmartPurifieriOS
//
//  Created by Wind on 2017/6/24.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface JXCommunityBannerCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;

@property (nonatomic,strong) NSArray *  advModelList;

@end
