//
//  CustomMyClarifierViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/2/14.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "CustomMyClarifierViewController.h"
#import "MyClarifierViewController.h"
@interface CustomMyClarifierViewController ()

@end

@implementation CustomMyClarifierViewController

- (NSArray<NSString *> *)titles {
    
    return @[@"我的净水机", @"收到的净水机"];
}

- (instancetype)init {
    if (self = [super init]) {
        self.menuViewStyle = WMMenuViewStyleLine;
       
        self.titleSizeSelected = 15.f;
        
        self.menuItemWidth = ((SCREEN_WIDTH-50)/2);
        
        self.titleColorNormal = [UIColor blackColor];
        
        self.menuBGColor = [UIColor whiteColor];
        
        self.titleColorSelected = SPNavBarColor;
        
        self.titleSizeNormal = 15.f;
        
        self.menuHeight = 44;
    }
    return self;
}


#pragma mark - WMPageController DataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
  
    return self.titles.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
   
    UIStoryboard * sb= [UIStoryboard storyboardWithName:@"User" bundle:nil];
    
    MyClarifierViewController * vc  =  [sb instantiateViewControllerWithIdentifier:@"MyClarifierViewControllerXBID"];
    
    vc.clarifierType = index;
    
    return vc;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
