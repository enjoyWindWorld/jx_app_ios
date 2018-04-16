//
//  MTabbarViewController.m
//  MyApp
//
//  Created by Amale on 16/4/27.
//  Copyright © 2016年 Wind. All rights reserved.
//

#import "SPTabbarViewController.h"
#import "SPHomePageElectricityEntrance.h"
#import "SPUserServiceElectricityEntrance.h"
#import "SPCommunityServiceElectricityEntrance.h"
#import "SPBaseNavViewController.h"
#import "AppDelegate.h"
#import "MyCenterViewController.h"
#import "SPUserModulesBusiness.h"

#import "RDVTabBarItem.h"
#import "UIImage+Common.h"
#import "STNavigationController.h"

#import "JXMovieHappyElectricityEntrance.h"
@interface SPTabbarViewController ()<RDVTabBarControllerDelegate>

@end

@implementation SPTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController * HomePageVC = [SPHomePageElectricityEntrance getHomePageViewController] ;
    
    UIViewController * CSvc = [SPCommunityServiceElectricityEntrance getCommunityServiceViewController] ;

    MyCenterViewController *userVC = [[MyCenterViewController alloc]init];
    
    
    UIViewController * movie = [JXMovieHappyElectricityEntrance fetchMovieHappyVC];
    
    UINavigationController *csNav = [[SPBaseNavViewController alloc]initWithRootViewController:CSvc];
   
    UINavigationController *userNav = [[SPBaseNavViewController alloc]initWithRootViewController:movie];
    
    UINavigationController *userNav1 = [[SPBaseNavViewController alloc]initWithRootViewController:userVC];

    UINavigationController *homeNav = [[SPBaseNavViewController alloc]initWithRootViewController:HomePageVC];
    

    [self setViewControllers:@[homeNav,csNav,userNav,userNav1]];
    
    [self customizeTabBarForController];
    
    [self reuestNotReadMessageCountData];
    
    self.delegate = self;

    // Do any additional setup after loading the view.
}

- (void)customizeTabBarForController {
    
    UIImage *backgroundImage = [UIImage imageWithColor:[UIColor colorWithHexString:@"F8F8F8"]];
    
    NSArray *tabBarItemImages = @[@"main", @"community",@"movie",@"mine"];
    
    NSArray *tabBarItemTitles = @[@"主页", @"社区服务",@"视频娱乐",@"我的"];
    
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        
        item.titlePositionAdjustment = UIOffsetMake(0, 3);
        
        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        
        [item setUnselectedTitleAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIFont systemFontOfSize:14], NSFontAttributeName,[UIColor lightGrayColor],NSForegroundColorAttributeName,
                                            nil]];
        
        [item setSelectedTitleAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont systemFontOfSize:14],
                                          NSFontAttributeName,[UIColor colorWithHexString:@"1bb6ef"],NSForegroundColorAttributeName,
                                          nil]];
        
        
        index++;
    }
    
    
}

+(void)setTabbarbadgeValueWith:(NSInteger)item badgeShow:(BOOL)isShow{

    
    UINavigationController * nav   = ((AppDelegate*)[UIApplication sharedApplication].delegate).tabbar.viewControllers[item];
    
    if (isShow) {
        
        [self addOneChild:nav title:@"我的" normalImage:@"tabbarUserNormalRed" selectImage:@"tabbarUserSelectRed"];
        
    }else{
    
         [self addOneChild:nav title:@"我的" normalImage:@"tabbarUserNormal" selectImage:@"tabbarUserSelect"];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
}

-(void)reuestNotReadMessageCountData{
    
    __weak typeof(self) weakself = self ;
    
    SPUserModulesBusiness  * all = [[SPUserModulesBusiness alloc] init];
    
    [all getNotReadMessageCount:@{} success:^(id result) {
        
        NSInteger count = [result  integerValue];
        
        count = MIN(count, 99);
        
        [[[weakself.tabBar items] objectAtIndex:3] setBadgeValue:[NSString stringWithFormat:@"%ld",count]];
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber: count];
        
    } failer:^(NSString *error) {
        
        
    }];
    
}

- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedViewController != viewController) {
        return YES;
    }
    if (![viewController isKindOfClass:[UINavigationController class]]) {
        return YES;
    }
    UINavigationController *nav = (UINavigationController *)viewController;
    if (nav.topViewController != nav.viewControllers[0]) {
        return YES;
    }
//    if ([nav.topViewController isKindOfClass:[RootViewController class]]) {
//        
//        RootViewController *rootVC = (RootViewController *)nav.topViewController;
//        
//        [rootVC tabBarItemClicked];
//    }
    
    
    return YES;
}

+ (void)addOneChild:(UIViewController *)childVC title:(NSString *)title normalImage:(NSString*)img selectImage:(NSString*)selectImg{
    
    
    
    UIImage *image = [UIImage imageNamed:img];
   
    UIImage *selectImage = [UIImage imageNamed:selectImg];
    
    childVC.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    childVC.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    
    childVC.tabBarItem.title = title ;
    
    [self selectedTapTabBarItems:childVC.tabBarItem];
    
    [self unSelectedTapTabBarItems:childVC.tabBarItem];
    
}

-(void)setTabbarApplication{

    //[[UITabBar appearance] setTranslucent:NO];
    
}




#pragma mark - unSelectedTapTabBarItems
+(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:13], NSFontAttributeName,[UIColor lightGrayColor],NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateNormal];
}

+(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:13],
                                        NSFontAttributeName,[UIColor colorWithHexString:@"1bb6ef"],NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateSelected];
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
