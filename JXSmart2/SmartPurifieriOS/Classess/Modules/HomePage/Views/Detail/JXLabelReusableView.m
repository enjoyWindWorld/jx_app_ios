//
//  JXLabelReusableView.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/27.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXLabelReusableView.h"

@implementation JXLabelReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)drawRect:(CGRect)rect{

    CGContextRef acontext = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(acontext, kCGLineCapRound);
    CGContextSetLineWidth(acontext, 1);
    CGContextSetAllowsAntialiasing(acontext, true);
    CGContextSetRGBStrokeColor(acontext, 235 / 255.0, 235 / 255.0, 241 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(acontext);
    CGContextMoveToPoint(acontext, 0, 0);  //起点坐标
    CGContextAddLineToPoint(acontext, self.size.width, 0);   //终点坐标
    CGContextStrokePath(acontext);
    
}

@end
