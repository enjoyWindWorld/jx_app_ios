//
//  JXWritePayManagerIDCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/8.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXWritePayManagerIDCell.h"

@implementation JXWritePayManagerIDCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)drawRect:(CGRect)rect{
    
    CGContextRef acontext = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(acontext, kCGLineCapRound);
    CGContextSetLineWidth(acontext, 1);
    CGContextSetAllowsAntialiasing(acontext, true);
    CGContextSetRGBStrokeColor(acontext, 235 / 255.0, 235 / 255.0, 241 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(acontext);
    CGContextMoveToPoint(acontext, 0, self.height-1);  //起点坐标
    CGContextAddLineToPoint(acontext, self.size.width, self.height-1);   //终点坐标
    CGContextStrokePath(acontext);
    
}
@end
