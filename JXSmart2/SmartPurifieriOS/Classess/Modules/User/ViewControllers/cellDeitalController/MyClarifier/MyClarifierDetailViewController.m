//
//  MyClarifierDetailViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "MyClarifierDetailViewController.h"
#import "FilterViewController.h"
#import "UserPurifierListModel.h"
#import "MyClarifierDetailCostViewController.h"
@interface MyClarifierDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *costDetailLabel;


@end

@implementation MyClarifierDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (_model) {
        
        self.navigationItem.title = [NSString stringWithFormat:@"%@(%@)",_model.name,_model.color];
        
        self.costDetailLabel.text = [NSString stringWithFormat:@"%@余量查询",_model.ord_protypeid==ClarifierCostType_YearFree?@"包年费用":@"流量费用"];
    }
    


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_model) {
        
        return ;
    }
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    if (indexPath.row==0) {
        
        //滤芯状态
        //cell点击事件
        FilterViewController *vc = [[FilterViewController alloc]init];
        
        vc.filterID = _model.pro_no;

        [self.navigationController pushViewController:vc animated:YES];

        
    }else if (indexPath.row==1){
    
        //费用
        [self performSegueWithIdentifier:@"MyClarifierDetailCostViewController" sender:_model];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"MyClarifierDetailCostViewController"]) {
        
        MyClarifierDetailCostViewController * vc = segue.destinationViewController;
        
        vc.model = sender;
        
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/

@end
