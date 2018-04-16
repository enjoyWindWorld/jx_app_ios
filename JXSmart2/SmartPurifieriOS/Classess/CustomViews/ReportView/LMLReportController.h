//
//  LMLReportController.h
//  Cell的折叠
//
//  Created by 优谱德 on 16/7/9.
//  Copyright © 2016年 董诗磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseViewController.h"

@interface LMLReportController : SPBaseViewController

@property (nonatomic, strong) NSArray *reasonInfo;

@property (nonatomic,copy)  void(^complationBlock)(NSString*content) ;

@end
