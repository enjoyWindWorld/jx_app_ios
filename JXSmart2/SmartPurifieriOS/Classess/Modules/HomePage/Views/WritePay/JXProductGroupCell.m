//
//  JXProductGroupCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/6.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXProductGroupCell.h"
#import "JXShoppingCarAttributeModel.h"
#import "JXShoppingCarModel.h"
@implementation JXProductGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JXShoppingCarModel *)model
{
    _model = model;

    [SPSDWebImage SPImageView:self.group_ico imageWithURL:model.url placeholderImage:[UIImage imageNamed:SPPRODUCTICOPLACEHOLDERImage]];
    
    _group_name.text = [NSString stringWithFormat:@"%@(%@)",model.name,model.color];
    
    _group_number.text = [NSString stringWithFormat:@"x%ld",model.number];
    
    NSString * yearsorflow  =model.yearsorflow ;
    
    yearsorflow = [yearsorflow stringByReplacingOccurrencesOfString:@"包年购买" withString:@"服务费包年购买"];
    
    _group_cost_ppdnum.text = yearsorflow;
    
    _group_price.text = [NSString stringWithFormat:@"￥%.2f元",model.totalPrice];
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
