//
//  JXMainPageProductCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/23.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXMainPageProductCell.h"

@implementation JXMainPageProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    

    // Initialization code
}

-(void)drawRect:(CGRect)rect{

//    [super drawRect:rect];
    NSLog(@"  rect  %@",NSStringFromCGRect(rect));
//    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 235 / 255.0, 235 / 255.0, 241 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, self.size.height-1);  //起点坐标
    CGContextAddLineToPoint(context, self.size.width, self.size.height-1);   //终点坐标
    CGContextStrokePath(context);
    
}

@end
