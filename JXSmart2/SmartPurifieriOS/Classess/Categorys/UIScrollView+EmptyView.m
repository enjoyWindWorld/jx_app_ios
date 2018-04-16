//
//  UIScrollView+EmptyView.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/23.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "UIScrollView+EmptyView.h"

@implementation UIScrollView (EmptyView)

-(void) addJXEmptyView{

    self.emptyDataSetSource = self ;
    
    self.emptyDataSetDelegate = self ;
    
}

-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString * title = @"暂无数据";
    
    return [[NSAttributedString alloc] initWithString:title attributes:nil];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    return [UIImage imageNamed:@"NoData@2x"];
}

-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    
    return YES ;
}

@end
