//
//  SPHomePageDetailHeaderView.m
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/14.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPHomePageDetailHeaderView.h"
#import "SDCycleScrollView.h"
#import "SPPurifierModel.h"

@interface SPHomePageDetailHeaderView ()

@property (nonatomic,strong) SDCycleScrollView * newcolorImageView;


@end


@implementation SPHomePageDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];

    if (self) {
        
        [self initUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }

    return self;
}

-(void)initUI{

    
    _newcolorImageView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) delegate:nil placeholderImage:nil];
    
    _newcolorImageView.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
    
    _newcolorImageView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
    
    _newcolorImageView.backgroundColor = [UIColor whiteColor];
    
    _newcolorImageView.autoScroll = NO ;
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom-1, SCREEN_WIDTH, 1)];
    
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self addSubview:view];
    
    [self addSubview:_newcolorImageView];

}

-(void)setColorArr:(NSArray *)colorArr{

    _colorArr = colorArr ;
    
    __block  NSArray * imgURL = @[];
    
    [colorArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SPProduceColorModel * colorModel = obj ;
        
        if (colorModel.isSelect) {
            
            imgURL = [colorModel.url componentsSeparatedByString:@","];
        }
        
        
    }];
    
    _newcolorImageView.imageURLStringsGroup = imgURL;
    
}



@end
