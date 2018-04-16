//
//  JXDetailDataColoCostTypeCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/27.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXDetailDataColoCostTypeCell.h"
#import "SPPurifierModel.h"

@implementation JXDetailDataColoCostTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_btn addTarget:self action:@selector(colorChanhge) forControlEvents:UIControlEventTouchUpInside];
    // Initialization code
}

-(void)setModel:(id)model{

    _model = model;
    
    if ([model isKindOfClass:[NSString class]]) {
        
        [_btn setTitle:model forState:UIControlStateNormal];
    }else if ([model isKindOfClass:[SPProduceColorModel class]]){
        
        SPProduceColorModel * color = model;
        
        if (color.isSelect) {
            
            [_btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_select",color.tone]] forState:UIControlStateNormal];
        }else{
            
            [_btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",color.tone]] forState:UIControlStateNormal];
        }
        
        [_btn setTitle:color.pic_color forState:UIControlStateNormal];
        
    }
    _btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
}

-(void)colorChanhge{

    if (_delegate && [_delegate respondsToSelector:@selector(cell_colorChange:)]) {
        
         SPProduceColorModel * color = _model;
        
        [_delegate cell_colorChange:color.tone];
    }
    
}


-(void)drawRect:(CGRect)rect{
    

    
}

@end
