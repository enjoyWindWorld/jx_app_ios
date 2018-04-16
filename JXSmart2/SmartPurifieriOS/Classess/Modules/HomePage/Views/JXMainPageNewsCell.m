//
//  JXMainPageNewsCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/24.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXMainPageNewsCell.h"
#import "JXMainPageModel.h"

@implementation JXMainPageNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setNews:(JXMainPageModel *)news{
    
    __block NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
    
    [news.home_page enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        JXMainAdvModel * model = obj;
        
        [arr addObject:model.adv_imgurl ];
        
    }];
    
    self.newsBanner.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
    
    self.newsBanner.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    
    self.newsBanner.backgroundColor = [UIColor whiteColor];
    
    self.newsBanner.autoScroll = YES ;
    
    NSLog(@"home adv = %@",arr);
    
    self.newsBanner.imageURLStringsGroup =arr;
    
    self.newsBanner.placeholderImage = [UIImage imageNamed:SPPRODUCTICOPLACEHOLDERImage];
    
    self.newsBanner.currentPageDotColor = SPNavBarColor;

    
    
}


@end
