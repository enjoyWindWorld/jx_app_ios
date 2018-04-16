//
//  UIScrollView+EmptyView.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/23.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIScrollView+EmptyDataSet.h>

@interface UIScrollView (EmptyView)<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

-(void) addJXEmptyView;

@end
