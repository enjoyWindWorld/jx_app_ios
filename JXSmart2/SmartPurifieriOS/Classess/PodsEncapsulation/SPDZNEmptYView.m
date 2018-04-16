//
//  SPDZNEmptYView.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/2/14.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPDZNEmptYView.h"

@implementation SPDZNEmptYView

-(void)addDZNEmpty:(UIScrollView*)scrollView{

    if (scrollView) {
        
        scrollView.emptyDataSetSource = self;
        
        scrollView.emptyDataSetDelegate = self;
        
    }
    
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
