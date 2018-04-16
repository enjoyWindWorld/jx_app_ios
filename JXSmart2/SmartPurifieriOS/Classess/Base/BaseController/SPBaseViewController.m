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
@property (nonatomic,strong) AlertViewAction tempStatus;

@end

@implementation SPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
}

-(void)compatibleAvailable_ios11:(UIScrollView*)scrollView{

    if (@available(iOS 11.0, *)) {
        
        //当contentInsetAdjustmentBehavior设置为UIScrollViewContentInsetAdjustmentNever的时候，adjustContentInset值不受SafeAreaInset值的影响。
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
}


@end
