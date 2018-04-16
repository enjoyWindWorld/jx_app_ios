//
//  SPDZNEmptYView.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/2/14.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPDZNEmptYView : NSObject<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

-(void)addDZNEmpty:(UIScrollView*)scrollView;

@end
