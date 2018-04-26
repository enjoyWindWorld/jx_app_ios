//
//  JXChildViewController.h
//  JXPartner
//
//  Created by Wind on 2018/4/27.
//  Copyright © 2018年 windpc. All rights reserved.
//

#import "JXBaseTableViewController.h"
#import "STNavBarView.h"

@interface JXChildViewController : JXBaseTableViewController

@property (nonatomic, weak) STNavBarView *navbar;

// 设置导航栏在最上层
- (void)bringNavBarToTopmost;

// 是否隐藏导航栏
- (void)hideNavBar:(BOOL)bIsHide;

// 设置STNavBarView 颜色
- (void)setNabbarBackgroundColor:(UIColor *)color;

// 设置标题
- (void)setNavBarTitle:(NSString *)strTitle;

// 设置导航栏左按钮
- (void)setNavBarLeftBtn:(UIButton *)btn;

// 设置导航栏右按钮
- (void)setNavBarRightBtn:(UIButton *)btn;

// 是否可右滑返回
- (void)navigationCanDragBack:(BOOL)canDragBack;


// 重设scroll view的内容区域和滚动条区域
- (void)resetScrollView:(UIScrollView *)scrollView tabBar:(BOOL)hasTabBar;

@end
