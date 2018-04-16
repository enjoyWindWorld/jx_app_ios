//
//  UIScrollView+RefreshView.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/23.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (RefreshView)


/**
 添加头部视图

 @param block 回调
 */
- (void)addJX_NormalHeaderRefreshBlock:(void (^)())block;


/**
 添加尾部视图

 @param block 回调
 */
- (void)addJX_NormalFooterRefreshBlock:(void (^)())block;


/**
 尾部添加暂无数据
 */
- (void)JXfooterEndNoMoreData;


/**
 头部尾部结束刷新
 */
- (void)JXendRefreshing;


/**
 删除刷新视图
 */
- (void)JXdelRefreshView;

@end
