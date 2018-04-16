//
//  CustomAfterSalesViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/3.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "CustomAfterSalesViewController.h"
#import "JXAfterSalesViewController.h"

@interface CustomAfterSalesViewController ()

@end

@implementation CustomAfterSalesViewController

- (NSArray<NSString *> *)titles {
    
    return @[@"进行中", @"已完成"];
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
    
    JXAfterSalesViewController * vc  =  [sb instantiateViewControllerWithIdentifier:@"JXAfterSalesViewControllerXBID"];
    
    vc.after_State = index == 0 ? 1 : 200 ;
    
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"售后与评价";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(request_NewAddSales)];
    // Do any additional setup after loading the view.
}

-(void)request_NewAddSales{
    
    UIStoryboard * sb= [UIStoryboard storyboardWithName:@"User" bundle:nil];
    
    UIViewController * vc  =  [sb instantiateViewControllerWithIdentifier:@"JXChooseAfterSalesTypeControllerXBID"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
