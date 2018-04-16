//
//  UIButton+TimerClass.m
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/28.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "UIButton+TimerClass.h"

@implementation UIButton (TimerClass)

-(void)statrTimerWithDefaultTime:(float)time block:(void (^)(NSTimer *timer))block{

    self.enabled = NO;
    
   __block NSInteger defaultTime = 120 ;
    
    
    __block  __weak typeof(self) weakself = self ;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(defaultTime <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
              
                weakself.enabled = YES;
            });
        }else{
           
            NSString *strTime = [NSString stringWithFormat:@"%ld秒后重新获取", (long)defaultTime];
            
            //回到主界面
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakself setTitleColor:[UIColor colorWithHexString:@"595656"] forState:UIControlStateDisabled];
                
                [weakself setTitle:strTime forState:UIControlStateDisabled];

            });

             defaultTime--;
            
        }
    });
    
    dispatch_resume(_timer);
    
//    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        
//        defaultTime --;
//        
//        [weakself setTitleColor:[UIColor colorWithHexString:@"595656"] forState:UIControlStateDisabled];
//        
//        [weakself setTitle:[NSString stringWithFormat:@"%lds后重新获取",defaultTime] forState:UIControlStateDisabled];
//        
//        DELog(@"  %ld",defaultTime);
//        
//        if (defaultTime<=0) {
//        
//            weakself.enabled = YES;
//            
//            [timer invalidate];
//            
//            timer = nil ;
//        }
//        
//    }];
//    
//    [timer fire];

}

-(void)automaticLessCount{


    
}




@end
