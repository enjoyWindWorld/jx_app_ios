//
//  WBaseViewController.m
//  MyApp
//
//  Created by Amale on 16/4/27.
//  Copyright © 2016年 Wind. All rights reserved.
//

#import "SPBaseViewController.h"
#import "UIViewController+Dealloc.h"
@interface SPBaseViewController ()

@end

@implementation SPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }

    if (@available(iOS 11.0, *)) {
        //以下两个属性任何一个设置成不可延伸至导航栏都会让页面起始点从导航栏下面开始
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
    
}





@end
