//
//  JXNewIncomeHeaderView.m
//  JXPartner
//
//  Created by windpc on 2017/9/6.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXNewIncomeHeaderView.h"


@implementation JXNewIncomeHeaderView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
      
        self.backgroundColor = HEXCOLORS(@"FA2C2D");
        
        _moneyLabel =  [[UILabel alloc] initWithFrame:CGRectMake(15, 30, SCREEN_WIDTH-30, 20)];
        
        _moneyLabel.textColor = [UIColor whiteColor];
        
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        
        _moneyLabel.font = [UIFont systemFontOfSize:16];
        
        _moneyLabel.text = @"提现金额";
        
        [self addSubview:_moneyLabel];
        
        _costMoneyLabel =  [[UILabel alloc] initWithFrame:CGRectMake(15,(self.height-15)/2, SCREEN_WIDTH-30, 30)];
        
        _costMoneyLabel.textColor = [UIColor whiteColor];
        
        _costMoneyLabel.font = [UIFont systemFontOfSize:25];
        
        _costMoneyLabel.textAlignment = NSTextAlignmentCenter;
        
        _costMoneyLabel.text = @"0";
        
        [self addSubview:_costMoneyLabel];
        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
