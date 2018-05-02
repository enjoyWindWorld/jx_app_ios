//
//  JXSubPartnerDetailTableViewController.m
//  JXPartner
//
//  Created by windpc on 2017/8/30.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXSubPartnerDetailTableViewController.h"
#import "JXSubPartnerModel.h"
#import "CustomMyOrderListViewController.h"
#import "JXSubPartnerUpdateTableViewController.h"

@interface JXSubPartnerDetailTableViewController ()

@end

@implementation JXSubPartnerDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_model) {
        
        self.title = [NSString stringWithFormat:@"%@的详情",_model.par_name];
    }
    
    [self.tableView addJXEmptyView];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    
    return 1;
    
    if (_model) {
        
        if (_model.permissions == 0) {
            
            return 2;
        }
        
        return 1 ;
    }
    return 0;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        //订单
        CustomMyOrderListViewController * vc = [[CustomMyOrderListViewController alloc] init];
        
        vc.title = [NSString stringWithFormat:@"%@的订单数据",_model.par_name];
        
        vc.model = _model;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 1){
    
        [self performSegueWithIdentifier:@"JXSubPartnerUpdateTableViewController" sender:nil];
    }
    

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"JXSubPartnerUpdateTableViewController"]) {
        
        JXSubPartnerUpdateTableViewController * vc = segue.destinationViewController ;
        
        vc.model = _model ;
        
    }
    
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
