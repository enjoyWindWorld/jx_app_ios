//
//  SPMJRefresh.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/14.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPMJRefresh.h"
#import <MJRefresh.h>

@implementation SPMJRefresh

+(BOOL)isContainHeader:(UIScrollView*)scrollView{

    return scrollView.mj_header?YES:NO;
}
/**
 *  添加默认head刷新
 *
 *  @param scrollView 需要添加刷新控件的试图
 *  @param block       进入刷新状态的回调
 */
+ (void)normalHeader:(UIScrollView *)scrollView refreshBlock:(SPRefreshComponentRefreshingBlock)block{

    if (scrollView.mj_header == nil) {
        scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (scrollView.mj_footer) {
                if (scrollView.mj_footer.state == MJRefreshStateNoMoreData) {
                    scrollView.mj_footer.state = MJRefreshStateIdle;
                }
            }
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"

            block();
            
#pragma clang diagnostic pop
        }];
    }

}

/**
 *  head 刷新控件开始刷新
 *
 *  @param scrollView headView的父试图
 */
+ (void)headerBeginRefreshing:(UIScrollView *)scrollView{

    if (scrollView.mj_header) {
        
        [scrollView.mj_header beginRefreshing];
    }
}

/**
 *  添加默认（自动加载更多）footer 刷新view
 *
 *  @param scrollView 需要添加刷新控件的试图
 *  @param block      进入刷新状态的回调
 */
+ (void)autoNormalFooter:(UIScrollView *)scrollView refreshBlock:(SPRefreshComponentRefreshingBlock)block{

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
    
    if (scrollView.mj_footer == nil) {
        scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
    }
    
#pragma clang diagnostic pop
    
    scrollView.mj_footer.automaticallyHidden = YES;
    
}

/**
 *  设置footer没有更多数据
 *
 *  @param scrollView footer的父试图
 */
+ (void)footerEndNoMoreData:(UIScrollView *)scrollView{

     [scrollView.mj_footer endRefreshingWithNoMoreData];
}



+ (void)resetNoMoreData:(UIScrollView *)scrollView{

     [scrollView.mj_footer resetNoMoreData];
}

/**
 *  停止刷新
 *
 *  @param scrollView 刷新控件的父试图
 */
+ (void)endRefreshing:(UIScrollView *)scrollView{

    if (scrollView.mj_header != nil) {
       
        if ([scrollView.mj_header isRefreshing])
        {
            [scrollView.mj_header endRefreshing];
        }
    }
    if (scrollView.mj_footer != nil) {
       
        if ([scrollView.mj_footer isRefreshing])
        {
            [scrollView.mj_footer endRefreshing];
        }
    }
}

/**
 *  删除上啦，下拉控件
 *
 *  @param scrollView 刷新控件的父试图
 */
+ (void)delRefreshView:(UIScrollView *)scrollView{

    [scrollView.mj_header removeFromSuperview];
    scrollView.mj_header = nil;
    [scrollView.mj_footer removeFromSuperview];
    scrollView.mj_footer = nil;
}


@end
