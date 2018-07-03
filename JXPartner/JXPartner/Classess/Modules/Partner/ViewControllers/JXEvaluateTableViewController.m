//
//  JXEvaluateTableViewController.m
//  JXPartner
//
//  Created by windpc on 2017/11/14.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXEvaluateTableViewController.h"
#import "CustomAfterSalesViewController.h"

@interface JXEvaluateTableViewController ()

@end

@implementation JXEvaluateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"售后管理";
    
    self.tableView.tableFooterView = [UIView new];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {

        [self performSegueWithIdentifier:@"JXPlanFilterLifeViewController" sender:nil];
    }

//    if (indexPath.section == 1) {
//
//        CustomAfterSalesViewController * vc = [[CustomAfterSalesViewController alloc] init];
//
//        [self.navigationController pushViewController:vc animated:YES];
//    }

    if (indexPath.section == 1) {

        [self performSegueWithIdentifier:@"JXFilterWarningViewController" sender:nil];
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50.f;
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
