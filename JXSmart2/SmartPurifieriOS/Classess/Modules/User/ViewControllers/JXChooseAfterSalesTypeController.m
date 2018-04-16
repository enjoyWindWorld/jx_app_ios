//
//  JXChooseAfterSalesTypeController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/3.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXChooseAfterSalesTypeController.h"
#import "JXNewAfterSalesViewController.h"

@interface JXChooseAfterSalesTypeController ()

@end

@implementation JXChooseAfterSalesTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.tableView.tableFooterView = [UIView new];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self  performSegueWithIdentifier:@"JXNewAfterSalesViewController" sender:indexPath];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"JXNewAfterSalesViewController"]) {
        
        NSIndexPath * index  = sender ;
        
        JXNewAfterSalesViewController * vc = segue.destinationViewController ;
        
        vc.afterSalesType = index.row + 1;
    }
    
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
