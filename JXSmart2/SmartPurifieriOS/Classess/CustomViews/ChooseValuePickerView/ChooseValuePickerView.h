//
//  ChooseValuePickerView.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/18.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseValuePickerView : UIView

/**Picker的标题*/
@property (nonatomic, copy) NSString * pickerTitle;

/**滚轮上显示的数据(必填,会根据数据多少自动设置弹层的高度)*/
@property (nonatomic, strong) NSArray * dataSource;

/**设置默认选项 (先设置dataArr,不设置默认选择第0个)*/
@property (nonatomic, assign) NSInteger  defaultChoose;

/**回调选择*/
@property (nonatomic, copy) void (^valueDidSelect)(NSInteger  chooseIndex);

@property (nonatomic, assign) NSInteger pickerHeight;    //弹层的高度

/**显示时间弹层*/
- (void)show;


@end
