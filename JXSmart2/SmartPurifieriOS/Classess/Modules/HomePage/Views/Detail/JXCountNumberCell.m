//
//  JXCountNumberCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/27.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXCountNumberCell.h"

@implementation JXCountNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)drawRect:(CGRect)rect{
    

    //
    CGContextRef acontext = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(acontext, kCGLineCapRound);
    CGContextSetLineWidth(acontext, 1);
    CGContextSetAllowsAntialiasing(acontext, true);
    CGContextSetRGBStrokeColor(acontext, 235 / 255.0, 235 / 255.0, 241 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(acontext);
    CGContextMoveToPoint(acontext, 0, 1);  //起点坐标
    CGContextAddLineToPoint(acontext, self.size.width, 1);   //终点坐标
    CGContextStrokePath(acontext);
    
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
