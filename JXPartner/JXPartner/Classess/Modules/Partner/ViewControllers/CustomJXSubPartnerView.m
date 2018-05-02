//
//  CustomJXSubPartnerView.m
//  JXPartner
//
//  Created by windpc on 2017/8/30.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "CustomJXSubPartnerView.h"
#import "JXSubParnerViewController.h"

@interface CustomJXSubPartnerView ()

@end

@implementation CustomJXSubPartnerView


- (NSArray<NSString *> *)titles {
    //全部 未付款 已付款 已绑定 未续费 已续费
    return @[@"直接成员",@"间接成员"];
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
    
    
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"JXPartner" bundle:nil];
    
    JXSubParnerViewController * vc  = [story instantiateViewControllerWithIdentifier:@"JXSubParnerViewControllerXBID"];
    
    vc.tag = index ;

    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
