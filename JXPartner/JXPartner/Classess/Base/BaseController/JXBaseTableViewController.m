//
//  JXBaseTableViewController.m
//  JXPartner
//
//  Created by windpc on 2017/10/18.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXBaseTableViewController.h"

@interface JXBaseTableViewController ()

@end

@implementation JXBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (@available(iOS 11.0, *)) {
        //以下两个属性任何一个设置成不可延伸至导航栏都会让页面起始点从导航栏下面开始
        self.extendedLayoutIncludesOpaqueBars = YES;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
