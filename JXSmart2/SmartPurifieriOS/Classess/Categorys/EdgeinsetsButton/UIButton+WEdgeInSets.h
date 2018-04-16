//
//  UIButton+WEdgeInSets.h
//  Myproject
//
//  Created by Amale on 16/8/3.
//  Copyright © 2016年 Wind. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, ButtonEdgeInsetsImageStyle) {
    ButtonEdgeInsetsImageStyleLeft,
    ButtonEdgeInsetsImageStyleRight,
    ButtonEdgeInsetsImageStyleTop,
    ButtonEdgeInsetsImageStyleBottom
};

@interface UIButton (WEdgeInSets)

/**
 *  自定义按钮内部position的image与title
 *
 *  @param style image 的位置
 *  @param space title 与image 的相对
 */
- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsImageStyle)style imageTitlespace:(CGFloat)space;

@end
