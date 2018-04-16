//
//  JXMainPageCommunityCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/24.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXMainPageCommunityCell.h"
#import "JXMainPageModel.h"
#import <UIButton+WebCache.h>
#import "UIButton+WEdgeInSets.h"

@implementation JXMainPageCommunityCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
}

-(void)setPageModel:(JXMainAdvModel *)pageModel{

     if (!pageModel) return;
        
    self.label.text = pageModel.adv_name;
    
    [SPSDWebImage SPImageView:self.ico imageWithURL:pageModel.adv_imgurl placeholderImage:[UIImage imageNamed:SPPRODUCTICOPLACEHOLDERImage]];


    
}

-(void)drawRect:(CGRect)rect{
    

//    NSLog(@"  rect  %@",NSStringFromCGRect(rect));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 235 / 255.0, 235 / 255.0, 241 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, self.size.height-1);  //起点坐标
    CGContextAddLineToPoint(context, self.size.width, self.size.height-1);   //终点坐标
    CGContextStrokePath(context);
    
    CGContextRef newcontext = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(newcontext, kCGLineCapRound);
    CGContextSetLineWidth(newcontext, 1);
    CGContextSetAllowsAntialiasing(newcontext, true);
    CGContextSetRGBStrokeColor(newcontext, 235 / 255.0, 235 / 255.0, 241 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(newcontext);
    CGContextMoveToPoint(newcontext, rect.size.width, 10);  //起点坐标
    CGContextAddLineToPoint(newcontext, rect.size.width, rect.size.height-10);   //终点坐标
    CGContextStrokePath(newcontext);
    
}

@end
