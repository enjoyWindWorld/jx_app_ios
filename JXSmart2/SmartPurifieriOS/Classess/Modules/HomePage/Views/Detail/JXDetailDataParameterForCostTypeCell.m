//
//  JXDetailDataParameterForCostTypeCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/27.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXDetailDataParameterForCostTypeCell.h"

@implementation JXDetailDataParameterForCostTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _numberBtn.delegate = self;
    
    [_selectBtn addTarget:self action:@selector(selectChange) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _numberBtn.maxValue = 3;
    _numberBtn.editing = YES ;
    // Initialization code
}


-(void)selectChange{

    if (_delegate &&[ _delegate respondsToSelector:@selector(cell_costTypeChange:)]) {
        
        [_delegate cell_costTypeChange:_item];
    }
    
}

-(void)pp_numberButton:(__kindof UIView *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus{

    if (_delegate &&[_delegate respondsToSelector:@selector(cell_pp_numberButton:number:increaseStatus:item:)]) {
        
        [_delegate cell_pp_numberButton:numberButton number:number increaseStatus:increaseStatus item:_item];
        
    }
}



@end
