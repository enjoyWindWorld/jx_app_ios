//
//  SPMJRefresh.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/14.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^SPRefreshComponentRefreshingBlock)();

typedef NS_ENUM (NSInteger,SPLoadingType)
{
    SPLoadingTypeCustom,
    
    SPLoadingTypeHeaderRefresh,
    
    SPLoadingTypeFooterRefresh
};

@interface SPMJRefresh : NSObject


+(BOOL)isContainHeader:(UIScrollView*)scrollView;

/**
 *  添加默认head刷新
 *
 *  @param scrollView 需要添加刷新控件的试图
 *  @param block       进入刷新状态的回调
 */
+ (void)normalHeader:(UIScrollView *)scrollView refreshBlock:(SPRefreshComponentRefreshingBlock)block;

/**
 *  head 刷新控件开始刷新
 *
 *  @param scrollView headView的父试图
 */
+ (void)headerBeginRefreshing:(UIScrollView *)scrollView;

/**
 *  添加默认（自动加载更多）footer 刷新view
 *
 *  @param scrollView 需要添加刷新控件的试图
 *  @param block      进入刷新状态的回调
 */
+ (void)autoNormalFooter:(UIScrollView *)scrollView refreshBlock:(SPRefreshComponentRefreshingBlock)block;

/**
 *  设置footer没有更多数据
 *
 *  @param scrollView footer的父试图
 */
+ (void)footerEndNoMoreData:(UIScrollView *)scrollView;



+ (void)resetNoMoreData:(UIScrollView *)scrollView;

/**
 *  停止刷新
 *
 *  @param scrollView 刷新控件的父试图
 */
+ (void)endRefreshing:(UIScrollView *)scrollView;

/**
 *  删除上啦，下拉控件
 *
 *  @param scrollView 刷新控件的父试图
 */
+ (void)delRefreshView:(UIScrollView *)scrollView;


@end
