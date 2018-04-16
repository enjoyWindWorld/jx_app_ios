//
//  ADRollView.m
//  OKSheng
//
//  Created by hztuen on 17/3/6.
//  Copyright © 2017年 hztuen. All rights reserved.
//

#import "ADRollView.h"
#import "Masonry.h"
//#import "UIColor+ColorHelper.h"

@interface ADRollView ()
{
    NSTimer *_timer;     //定时器
    int count;
    int flag; //标识当前是哪个view显示(currentView/hidenView)
    NSMutableArray *_dataArr;
    
    dispatch_source_t _sourceTimer;
}

@property (nonatomic,strong) UIView *currentView;   //当前显示的view
@property (nonatomic,strong) UIView *hidenView;     //底部藏起的view

//当前显示的内容
@property (nonatomic,strong) UILabel *currentLabel;
@property (nonatomic,strong) UIButton *currentBtn;
@property (nonatomic,strong) UILabel *currentTimeLabel;

//未显示的内容
@property (nonatomic,strong) UIButton *hidenBtn;
@property (nonatomic,strong) UILabel *hidenLabel;
@property (nonatomic,strong) UILabel *hidenTimeLabel;

@end

@implementation ADRollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    self  = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self createUI];
    }
    
    return self ;
}

- (void)createUI
{
    count = 0;
    flag = 0;
    
    self.layer.masksToBounds = YES;
    
    
    [self createCurrentView];
    [self createHidenView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dealTap:)];
    [self addGestureRecognizer:tap];
    //改进
    UILongPressGestureRecognizer*longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(dealLongPress:)];
    [self addGestureRecognizer:longPress];
    
}

- (void)dealTap:(UITapGestureRecognizer *)tap
{
    if (self.clickBlock) {
        self.clickBlock(count);
    }
}

-(void)dealLongPress:(UILongPressGestureRecognizer*)longPress{
    
    if(longPress.state==UIGestureRecognizerStateEnded){
        
        _timer.fireDate=[NSDate distantPast];
        
        
    }
    if(longPress.state==UIGestureRecognizerStateBegan){
        
        _timer.fireDate=[NSDate distantFuture];
    }
    
}

- (void)setVerticalShowDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    ADRollModel *model = _dataArr[count];
    [self.currentBtn setTitle:model.noticeType forState:UIControlStateNormal];
    self.currentLabel.text = model.noticeTitle;
    self.currentTimeLabel.text = model.addTime;
}

#pragma mark - 跑马灯操作
-(void)dealTimer
{
    count++;
    if (count == _dataArr.count) {
        count = 0;
    }
    
    if (flag == 1) {
        ADRollModel *currentModel = _dataArr[count];
        [self.currentBtn setTitle:currentModel.noticeType forState:UIControlStateNormal];
        self.currentLabel.text = currentModel.noticeTitle;
        self.currentTimeLabel.text = currentModel.addTime;
    }
    
    if (flag == 0) {
        ADRollModel *hienModel = _dataArr[count];
        [self.hidenBtn setTitle:hienModel.noticeType forState:UIControlStateNormal];
        self.hidenLabel.text = hienModel.noticeTitle;
        self.hidenTimeLabel.text = hienModel.addTime;
    }
    
    
    if (flag == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.currentView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            flag = 1;
            self.currentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.hidenView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            self.hidenView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            flag = 0;
            self.hidenView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.width);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.currentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
}


- (void)createTimer
{
//    _timer=[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(dealTimer) userInfo:nil repeats:YES];
    
    if (_dataArr.count <=1) {
        
        return ;
    }
    
    NSTimeInterval period = 3;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
     _sourceTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_sourceTimer, DISPATCH_TIME_NOW, period * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_sourceTimer, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //在这里执行事件
            [self  dealTimer];
            
        });
        
    });
    
    dispatch_resume(_sourceTimer);
    
    
}

- (void)createCurrentView
{
    ADRollModel *model = _dataArr[count];
    
    self.currentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.currentView];
    
//    self.currentView.backgroundColor =[ UIColor redColor];
    //此处是类型按钮(不需要点击)
    self.currentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.currentBtn.frame = CGRectMake(5, (self.currentView.frame.size.height-35)/2, self.currentView.width*0.3, self.currentView.height);
    [self.currentBtn setTitle:model.noticeType forState:UIControlStateNormal];
    [self.currentBtn setTitleColor:[UIColor colorWithHexString:@"F49F28" alpha:1.0] forState:UIControlStateNormal];
    self.currentBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.currentBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.currentView addSubview:self.currentBtn];
    
    //时间
//    self.currentTimeLabel = [[UILabel alloc] init];
//    self.currentTimeLabel.textColor = [UIColor colorWithHexString:@"666666" alpha:1.0];
//    self.currentTimeLabel.font = [UIFont systemFontOfSize:12];
//    self.currentTimeLabel.textAlignment = NSTextAlignmentRight;
//    [self.currentView addSubview:self.currentTimeLabel];
//    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.currentBtn.mas_centerY);
//        make.right.equalTo(self.currentView.mas_right).offset(-10);
//        make.width.mas_equalTo(@70);
//    }];
    
    //内容标题
    self.currentLabel = [[UILabel alloc]init];
    self.currentLabel.text = model.noticeTitle;
    self.currentLabel.textAlignment = NSTextAlignmentLeft;
    self.currentLabel.textColor = [UIColor colorWithHexString:@"666666" alpha:1.0];
    self.currentLabel.font = [UIFont systemFontOfSize:15];
    [self.currentView addSubview:self.currentLabel];
    [self.currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.currentBtn.mas_centerY);
        make.left.equalTo(self.currentBtn.mas_right).offset(5);
        make.right.equalTo(self.currentView.mas_right).offset(0);
        make.height.equalTo(self.currentView.mas_height);
    }];

}

- (void)createHidenView
{
    self.hidenView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.hidenView];
    
    //此处是类型按钮(不需要点击)
    self.hidenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hidenBtn.frame = CGRectMake(5, (self.currentView.frame.size.height-35)/2, self.hidenView.width*0.3, self.hidenView.height);
    [self.hidenBtn setTitle:@"" forState:UIControlStateNormal];
    [self.hidenBtn setTitleColor:[UIColor colorWithHexString:@"F49F28" alpha:1.0] forState:UIControlStateNormal];
    self.hidenBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.hidenBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.hidenView addSubview:self.hidenBtn];
    
//    self.hidenTimeLabel = [[UILabel alloc] init];
//    self.hidenTimeLabel.textColor = [UIColor colorWithHexString:@"666666" alpha:1.0];
//    self.hidenTimeLabel.font = [UIFont systemFontOfSize:12];
//    self.hidenTimeLabel.textAlignment = NSTextAlignmentRight;
//    [self.hidenView addSubview:self.hidenTimeLabel];
//    [self.hidenTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.hidenBtn.mas_centerY);
//        make.right.equalTo(self.hidenView.mas_right).offset(-10);
//        make.width.mas_equalTo(@70);
//    }];
    
    //内容标题
    self.hidenLabel = [[UILabel alloc]init];
    self.hidenLabel.text = @"";
    self.hidenLabel.textAlignment = NSTextAlignmentLeft;
    self.hidenLabel.textColor = [UIColor colorWithHexString:@"666666" alpha:1.0];
    self.hidenLabel.font = [UIFont systemFontOfSize:15];
    [self.hidenView addSubview:self.hidenLabel];
    [self.hidenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.hidenBtn.mas_centerY);
        make.left.equalTo(self.hidenBtn.mas_right).offset(5);
        make.right.equalTo(self.hidenView.mas_right).offset(0);
        make.height.equalTo(self.hidenView.mas_height);
    }];
    
}


#pragma mark - 开始／停止定时器

- (void)start {
    //创建定时器
    [self createTimer];
}

- (void)stopTimer {
    //停止定时器
//    if ([_timer isValid] == YES) {
//        [_timer invalidate];
//        _timer = nil;
//    }
    
    if (_sourceTimer) {
        
        dispatch_source_cancel(_sourceTimer);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
