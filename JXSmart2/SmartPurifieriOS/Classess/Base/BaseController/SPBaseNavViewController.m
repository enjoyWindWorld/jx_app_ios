//
//  WBaseNavViewController.m
//  MyApp
//
//  Created by Amale on 16/4/27.
//  Copyright © 2016年 Wind. All rights reserved.
//

#import "SPBaseNavViewController.h"

@interface SPBaseNavViewController ()<UINavigationBarDelegate>

@end

@implementation SPBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBarTheme];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationBarTheme
{
    
    //设置导航视图上的背景色
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithHexString:@"525252"]];
    
    //设置系统自带的返回按钮图片
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"nav_back_left"]];
    
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"nav_back_left"]];
    
    //设置导航栏title颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"525252"]}];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]}
                                               ];
    
    //导航系统自带的返回按钮上的文字隐藏
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]}
                                                forState:UIControlStateNormal];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithHexString:@"525252"]];
    
    self.navigationBar.translucent = NO;
    
//    [self hideBorderInView:self.navigationBar];
    
}


- (void)hideBorderInView:(UIView *)view{
    if ([view isKindOfClass:[UIImageView class]]
        && view.frame.size.height <= 1) {
        view.hidden = YES;
    }
    for (UIView *subView in view.subviews) {
        [self hideBorderInView:subView];
    }
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    [super pushViewController:viewController animated:YES];

    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
