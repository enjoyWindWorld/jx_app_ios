//
//  UIButton+TimerClass.h
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/28.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TimerClass)

-(void)statrTimerWithDefaultTime:(float)time block:(void (^)(NSTimer *timer))block;

@end
