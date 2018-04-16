//
//  JXCommunityDetailHeader.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/27.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface JXCommunityDetailHeader : UIView

@property (nonatomic,strong) SDCycleScrollView * mainBannerView ;

@property (nonatomic,strong) UILabel * liulanLabel ;



-(instancetype)initWithFrame:(CGRect)frame;

@end
