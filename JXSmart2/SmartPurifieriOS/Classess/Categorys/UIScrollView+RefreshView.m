//
//  UIScrollView+RefreshView.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/23.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "UIScrollView+RefreshView.h"
#import <MJRefresh.h>

@implementation UIScrollView (RefreshView)

/**
 添加头部视图
 
 @param block 回调
 */
- (void)addJX_NormalHeaderRefreshBlock:(void (^)())block{

    if (self.mj_header == nil) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
            if (self.mj_footer) {
                if (self.mj_footer.state == MJRefreshStateNoMoreData) {
                    self.mj_footer.state = MJRefreshStateIdle;
                }
            }
            block();
            
#pragma clang diagnostic pop
        }];
    }
}


/**
 添加尾部视图
 
 @param block 回调
 */
- (void)addJX_NormalFooterRefreshBlock:(void (^)())block{

    if (self.mj_footer == nil) {
        
        self.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:block];
    }
    
    self.mj_footer.automaticallyHidden = YES;
}


/**
 尾部添加暂无数据
 */
- (void)JXfooterEndNoMoreData{

    if (self.mj_footer) {
        
        [self.mj_footer endRefreshingWithNoMoreData];
    }
    
}


/**
 头部尾部结束刷新
 */
- (void)JXendRefreshing{

    if (self.mj_footer) {
        
        [self.mj_footer endRefreshing];
    }
    
    if (self.mj_header) {
        
        [self.mj_header endRefreshing];
    }
    
}


/**
 删除刷新视图
 */
- (void)JXdelRefreshView{

    [self.mj_header removeFromSuperview];
    
    self.mj_header = nil;
    
    [self.mj_footer removeFromSuperview];
    
    self.mj_footer = nil;
    
}


@end
