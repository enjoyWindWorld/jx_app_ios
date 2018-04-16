//
//  JXMainTodayTradingCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/24.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXMainTodayTradingCell.h"
#import "JXWaterQualityReportModel.h"

@implementation JXMainTodayTradingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JXWaterQualityReportModel *)model{

    
    NSArray * water = model.water_quality;
    
    NSArray * current_exponent = model.current_exponent;
    
    if (water.count>2) {
        
        _waterFirst.text = ((JXWaterQuality*)water[0]).water_quality;
        _waterFirst.adjustsFontSizeToFitWidth = YES;
        _waterTwo.text =  ((JXWaterQuality*)water[1]).water_quality;
        _waterTwo.adjustsFontSizeToFitWidth = YES;
        _waterThree.text =  ((JXWaterQuality*)water[2]).water_quality;
        _waterThree.adjustsFontSizeToFitWidth = YES;
        
    }
    
    if (water.count>2) {
        _reportFirst.text = ((JXCurrent_exponent*)current_exponent[0]).current_exponent;
        _reportFirst.adjustsFontSizeToFitWidth = YES;
        _reportTwo.text = ((JXCurrent_exponent*)current_exponent[1]).current_exponent;
        _waterTwo.adjustsFontSizeToFitWidth = YES;
        _reportThree.text = ((JXCurrent_exponent*)current_exponent[2]).current_exponent;
        _waterThree.adjustsFontSizeToFitWidth = YES ;
    }
}


@end
