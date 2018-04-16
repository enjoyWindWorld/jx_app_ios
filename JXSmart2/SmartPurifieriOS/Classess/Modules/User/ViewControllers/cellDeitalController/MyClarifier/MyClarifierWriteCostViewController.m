//
//  MyClarifierWriteCostViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "MyClarifierWriteCostViewController.h"
#import "MyClarifierWriteCostTableViewCell.h"
#import "SPHomePageElectricityEntrance.h"
#import "SPClarifierTrafficModel.h"
#import "SPUserModulesBusiness.h"
#import "OrderDetailModel.h"

@interface MyClarifierWriteCostViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) SPClarifierWirtePayModel * writeModel;

@end

@implementation MyClarifierWriteCostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"填写支付详情";
    
    [self  compatibleAvailable_ios11:_myTableView];
    
    [self fetchOrderPayResoult];
    
}

-(void)fetchOrderPayResoult{
    
    NSString * orn_on = _listModel.ord_no;
    
     __weak typeof(self) weakself = self ;
    
    [SPSVProgressHUD showWithStatus:@"请稍候..."];
    
    SPUserModulesBusiness * bussiness = [[SPUserModulesBusiness  alloc] init];
    
    [bussiness getUserOrderRenewalDetail:@{@"ord_no":orn_on,@"productId":_listModel.productId} success:^(id result) {
        
        [SVProgressHUD dismiss];
        
        if (result) {
            
            OrderDetailModel * model = result;
 
            _writeModel = [[SPClarifierWirtePayModel alloc]init];
            
            _writeModel.addressName = model.name;
            
            _writeModel.phone = model.phone;
            
            _writeModel.detail = model.address;
            
            _writeModel.proname = _listModel.pro_name;
            
            _writeModel.proColor = model.color;
            
            _writeModel.prourl = model.url;

            for (SPOrderDetailPriceModel * amodel in model.priceArr) {
                
                if (amodel.paytype==ClarifierCostType_YearFree) {
                    
                    _writeModel.yearfree = amodel.price;
                }else if (amodel.paytype==ClarifierCostType_TrafficFree){
                
                    _writeModel.trafficfree = amodel.price;
                }
                
            }
           
            
            [weakself.myTableView reloadData];

        }
        
    } failer:^(NSString *error) {
        
        [SVProgressHUD dismiss];
        
        [SPToastHUD makeToast:error duration:2.5 position:nil makeView:weakself.view];
    }];
    
}


#pragma mark - 点击支付
- (IBAction)payFreeAction:(id)sender {
    
    if (_writeModel) {
        
        NSString * free = _writeModel.type==ClarifierCostType_YearFree?_writeModel.yearfree:_writeModel.trafficfree;
        
        
         [SPSVProgressHUD showWithStatus:@"正在生成订单中.."];
        
         __weak typeof(self) weakself = self ;
        
        SPUserModulesBusiness * bussiness = [[SPUserModulesBusiness  alloc] init];
        
        [bussiness getClarifierAddOrderCost:@{@"ord_no":_listModel.ord_no,@"paytype":[NSNumber numberWithInteger:_writeModel.type],@"price":free,@"proname":_writeModel.proname} success:^(id result) {
            
            [SVProgressHUD dismiss];
            
            UIViewController * vc = [SPHomePageElectricityEntrance getPayDetailViewController:result];
            //
            [self.navigationController pushViewController:vc animated:YES];
            
        } failer:^(NSString *error) {
            
            [SVProgressHUD dismiss];
            
            [SPToastHUD makeToast:error duration:2.5 position:nil makeView:weakself.view];
        }];
    }
    
}



#pragma mark -UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (!_writeModel) {
        
        return 0;
    }
    
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [MyClarifierWriteCostTableViewCell tableView:tableView CellWithIndex:indexPath itemModel:_writeModel];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) return 1;
    
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==1 && indexPath.row>2) {
        
        _writeModel.type = indexPath.row-3;
        
        [_myTableView reloadData];
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return .1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [MyClarifierWriteCostTableViewCell tableView:tableView heightForIndex:indexPath itemModel:_writeModel];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section==0) {
        
        return 10.f;
    }
    
    return .1f;
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
