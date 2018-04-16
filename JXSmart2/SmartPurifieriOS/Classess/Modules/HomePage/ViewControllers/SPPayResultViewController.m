//
//  SPPayResultViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/29.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPPayResultViewController.h"
#import "OrderDetailModel.h"

@interface SPPayResultViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property (weak, nonatomic) IBOutlet UILabel *payPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *proname;

@property (weak, nonatomic) IBOutlet UILabel *paytime;
@property (weak, nonatomic) IBOutlet UILabel *payway;

@property (weak, nonatomic) IBOutlet UILabel *payorderon;
@end

@implementation SPPayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"支付结果";

    UIBarButtonItem * btn_Item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_left"] style:UIBarButtonItemStylePlain target:self action:@selector(viewGObACK)];
    
    self.navigationItem.leftBarButtonItems = @[btn_Item];
    
    _payPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f",_orderModel.price];
    
    _payorderon.text = _orderModel.ordNo;
    
    _payway.text = [_orderModel.way integerValue] ==0?@"支付宝支付":@"微信支付";
    
    _paytime.text = _orderModel.ord_modtime;
    
    NSString * payWyae = @"";
    
    if (_orderModel.isagain==SPAddorder_Type_PAY) {
        
        payWyae = _orderModel.paytype==ClarifierCostType_YearFree?@"包年费用":@"流量预付";
        
    }else if (_orderModel.isagain==SPAddorder_Type_Renewal){
        
        payWyae = _orderModel.paytype==ClarifierCostType_YearFree?@"包年续费":@"流量续费";
    }
    
    _proname.text = [NSString stringWithFormat:@"%@(%@)%@",_orderModel.name,_orderModel.color,payWyae];
    
    
    
}

-(void)viewGObACK{

    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
