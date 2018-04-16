//
//  JXCommunityBannerCell.m
//  SmartPurifieriOS
//
//  Created by Wind on 2017/6/24.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXCommunityBannerCell.h"
#import "JXCommunityAdvModel.h"

@implementation JXCommunityBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    

    _bannerView.placeholderImage = [UIImage imageNamed:@"CommunityNoPicture@2x"];
    
    _bannerView.backgroundColor = [UIColor whiteColor];
    
    _bannerView.localizationImageNamesGroup = @[];
    
//    _bannerView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    _bannerView.autoScrollTimeInterval = 3.;
    
    _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    _bannerView.titleLabelBackgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];// 图片对应的标题的 背景色。（因为没有设标题）
    
    _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    
    _bannerView.currentPageDotColor = SPNavBarColor;
    
    
    // Initialization code
}

-(void)setAdvModelList:(NSArray *)advModelList{

    _advModelList = advModelList;
    
    NSMutableArray * arr = @[].mutableCopy;
    
    [_advModelList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        JXCommunityAdvModel * model = obj;
        
        [arr addObject:model.adv_imgurl];
        
    }];
    
    _bannerView.imageURLStringsGroup = arr;
    
}



@end
