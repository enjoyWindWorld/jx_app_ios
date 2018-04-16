//
//  CustomMyOrderListViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/13.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "CustomMyOrderListViewController.h"
#import "MyOrderViewController.h"

@interface CustomMyOrderListViewController ()

@end

@implementation CustomMyOrderListViewController

- (NSArray<NSString *> *)titles {
    //全部 未付款 已付款 已绑定 未续费 已续费
    return @[@"已付款",@"已绑定",@"续费"];
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.menuViewStyle = WMMenuViewStyleLine;
        
        self.titleSizeSelected = 15.f;
        
        self.menuItemWidth = ((SCREEN_WIDTH-50)/5);
        
        self.titleColorNormal = [UIColor blackColor];
        
        self.menuBGColor = [UIColor whiteColor];
        
        self.titleColorSelected = HEXCOLORS(@"B70017");
        
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
    
    MyOrderViewController * vc  = [[MyOrderViewController alloc] init];
    
    vc.model = _model ;
    
    NSString * state = @"";
    
    if (index==0){
         state = @"1";
    }else if (index==1){
        
         state = @"3";
    }else if (index==2){
         state = @"4,5";
    }
    vc.state = state;
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
