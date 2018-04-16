//
//  JXCommunityDetailHeader.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/27.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXCommunityDetailHeader.h"

@implementation JXCommunityDetailHeader

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        _mainBannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) imageURLStringsGroup:@[]];
        
        _mainBannerView.placeholderImage = [UIImage imageNamed:SPPRODUCTICOPLACEHOLDERImage];
        
        _mainBannerView.backgroundColor = [UIColor whiteColor];
        
        _mainBannerView.localizationImageNamesGroup = @[];
    
        _mainBannerView.autoScrollTimeInterval = 3.;
        
        _mainBannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        
        _mainBannerView.titleLabelBackgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];// 图片对应的标题的 背景色。（因为没有设标题）
        
        _mainBannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        
        _mainBannerView.currentPageDotColor = SPNavBarColor;
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _mainBannerView.bottom-45, SCREEN_WIDTH, 45)];
        
        imageView.image = [UIImage imageNamed:@"communitybg"];
        
        [self addSubview:_mainBannerView];
        
        [self addSubview:imageView];
        
        _liulanLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _mainBannerView.bottom-45, SCREEN_WIDTH, 45)];
        
        _liulanLabel.text = @"";
        
        _liulanLabel.font = [UIFont systemFontOfSize:16];
        
        _liulanLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:_liulanLabel];
        
        
    }
    
   return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
