//
//  SPChooseDateView.h
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/29.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPChooseDateView : UIView

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic ,copy) void(^actionTime)(NSString*dataTime);

-(instancetype)initWithFrame:(CGRect)frame dataPickType:(UIDatePickerMode)model dataPickHeght:(CGFloat)dataHeght;

-(void) dateViewShowAction;


-(void) dateViewHideAction;


@end
