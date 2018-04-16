//
//  SPChooseDateView.m
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/29.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPChooseDateView.h"

#define  TOOLBAR_HEIGHT 40

@interface SPChooseDateView ()

@property (nonatomic ,strong) UIView * bottomView;       //底层视图

@end

@implementation SPChooseDateView


-(instancetype)initWithFrame:(CGRect)frame dataPickType:(UIDatePickerMode)model dataPickHeght:(CGFloat)dataHeght{

   self =  [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];

    if (self) {
        
        self.userInteractionEnabled = YES ;
       
        self.backgroundColor = [UIColor colorWithHexString:@"232323" alpha:0.5];
    
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, dataHeght)];
        
        self.bottomView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.bottomView];

//        UIToolbar * toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, TOOLBAR_HEIGHT)];
//        
//        toolBar.barStyle = UIBarStyleDefault;
//        
//        UIBarButtonItem *cancelBar = [[UIBarButtonItem alloc] initWithTitle:@"   取消"
//                                                                      style:UIBarButtonItemStylePlain
//                                                                     target:self
//                                                                     action:@selector(toolbarCanelAction)];
//        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
//                                                                               target:Nil
//                                                                               action:nil];
//        UIBarButtonItem *doneBar = [[UIBarButtonItem alloc] initWithTitle:@"确定   "
//                                                                    style:UIBarButtonItemStylePlain
//                                                                   target:self
//                                                                   action:@selector(toolbarDoneAction)];
//        [cancelBar setTintColor:[UIColor colorWithHexString:@"777777"] ];
//        
//        
//        
//        [doneBar setTintColor:[UIColor colorWithHexString:@"777777"] ];
//        
//        [toolBar setItems:[NSArray arrayWithObjects:cancelBar, space, doneBar, nil]];
//
        _datePicker = [[UIDatePicker alloc] init];
        
        _datePicker.frame = CGRectMake(0,TOOLBAR_HEIGHT/2, SCREEN_WIDTH, dataHeght);
        
        _datePicker.datePickerMode = model;
        
        [_datePicker setValue:[UIColor colorWithHexString:@"333333"] forKey:@"textColor"];
       
        _datePicker.backgroundColor = [UIColor whiteColor];
       
        _datePicker.datePickerMode = model;
        
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        
        _datePicker.minimumDate = [NSDate date];
    
        [self.bottomView addSubview:_datePicker];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0,TOOLBAR_HEIGHT,SCREEN_WIDTH, 1)];
        
        [line setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        [self.bottomView addSubview:line];
        
        UIButton * cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [cancle setTitle:@"取消" forState:UIControlStateNormal];
        
        [cancle setTitleColor:HEXCOLOR(@"333333") forState:UIControlStateNormal];
        
        [cancle addTarget:self action:@selector(toolbarCanelAction) forControlEvents:UIControlEventTouchUpInside];
        
        cancle.titleLabel.font = [UIFont systemFontOfSize:17];
        
        cancle.frame = CGRectMake(15, 0, 50, TOOLBAR_HEIGHT);
        
        [self.bottomView addSubview:cancle];
        
        UIButton * doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        
        [doneBtn setTitleColor:HEXCOLOR(@"333333") forState:UIControlStateNormal];
        
        [doneBtn addTarget:self action:@selector(toolbarDoneAction) forControlEvents:UIControlEventTouchUpInside];
        
        doneBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        doneBtn.frame = CGRectMake(SCREEN_WIDTH-65, 0, 50, TOOLBAR_HEIGHT);
        
        [self.bottomView addSubview:doneBtn];
        
    }
    
    return self;
}

-(void) dateViewShowAction{
    
    [[[[UIApplication sharedApplication]delegate]window] addSubview:self];
    
    CGRect frame = self.bottomView.frame ;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            [self.bottomView setFrame:CGRectMake(0,
                                                    self.height -self.bottomView.height,
                                                      frame.size.width,
                                                     frame.size.height)
                             ];
                        }completion:nil];
    

}


-(void) dateViewHideAction{

    CGRect frame = self.bottomView.frame ;
    
  __block  __weak typeof(self) weakself = self ;
  
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
       
        [weakself.bottomView setFrame:CGRectMake(0, SCREEN_HEIGHT,SCREEN_WIDTH, frame.size.height)];
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];

}

-(void)toolbarCanelAction{

    [self dateViewHideAction];
    
}

-(void)toolbarDoneAction{
    
    NSString * string = [NSDate getTimeStringWithDate:_datePicker.date];
 
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
    if (_actionTime) {
        
        _actionTime(string);
    }
#pragma clang diagnostic pop
    
    [self dateViewHideAction];
    
}

/**点击背景释放界面*/
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dateViewHideAction];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
