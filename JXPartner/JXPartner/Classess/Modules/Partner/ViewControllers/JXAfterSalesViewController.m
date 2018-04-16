//
//  JXAfterSalesViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/3.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXAfterSalesViewController.h"
#import "JXPartnerBusiness.h"
#import "JXAfterListTableViewCell.h"
#import "JXAfterListModel.h"
#import "JXNewAfterSalesViewController.h"
#import "JXPlanFilterLifeModel.h"

@interface JXAfterSalesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray * datas ;

@property (nonatomic,strong) JXPartnerBusiness * business ;

@property (nonatomic,assign) NSInteger  currentPage ;
@end

@implementation JXAfterSalesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentPage = 1 ;
    
    _datas = [NSMutableArray arrayWithCapacity:0];

    [self.myTableView addJXEmptyView];
    
    __weak typeof(self) weakself = self ;
    
    [self.myTableView addJX_NormalHeaderRefreshBlock:^{
        
        if (weakself.currentRepairList) {
            
            [weakself request_fetchRepairList:1];
            
        }else{
            
            
            [weakself requestAfteSalesList:1];
        }
        
    }];
    
    [self.myTableView addJX_NormalFooterRefreshBlock:^{
        
        if (weakself.currentRepairList) {
            
            [weakself  request_fetchRepairList:weakself.currentPage +1 ];
            
        }else{

            [weakself requestAfteSalesList:_currentPage+1];
        }

    }];

    self.myTableView.tableFooterView = [UIView new];

    [self.myTableView jxHeaderStartRefresh];
    
}


-(void)requestAfteSalesList:(NSInteger)page{

     _currentPage = page ;

    __weak typeof(self) weakself = self ;
    
    [self.business fetchAfterSalesList:@{@"fas_state":@(_after_State),@"page":@(page)} success:^(id result) {

        [weakself.myTableView JXendRefreshing];

        NSArray * resultArr = result ;

        if (weakself.currentPage == 1) {

            [weakself.datas removeAllObjects];
        }

        if (resultArr.count==0) {

            [weakself.myTableView JXfooterEndNoMoreData];
        }

        [weakself.datas addObjectsFromArray:resultArr];

        [weakself.myTableView reloadData];
        
    } failer:^(id error) {

        [weakself.myTableView JXendRefreshing];

        [weakself makeToast:error duration:3 position:nil];
    }];
    
    
}

/**
 获得维修记录

 @param page
 */
-(void)request_fetchRepairList:(NSInteger)page{

    _currentPage = page ;

    __weak typeof(self) weakself = self ;

    [self.business fetchProductRepairList:@{@"page":@"1",@"pro_no":_model.pro_no,@"ord_no":_model.ord_no} success:^(id result) {

        [weakself.myTableView JXendRefreshing];

        NSArray * resultArr = result ;

        if (weakself.currentPage == 1) {

            [weakself.datas removeAllObjects];
        }

        if (resultArr.count==0) {

            [weakself.myTableView JXfooterEndNoMoreData];
        }

        [weakself.datas addObjectsFromArray:resultArr];

        [weakself.myTableView reloadData];

    } failer:^(id error) {

        [weakself.myTableView JXendRefreshing];

        [weakself makeToast:error duration:3 position:nil];
    }];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JXAfterListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (_datas.count > indexPath.row) {

        JXAfterListModel * model = _datas[indexPath.row];

        cell.cell_time.text = model.fas_addtime;
        cell.cell_contactPer.text = [NSString stringWithFormat:@"联系人:%@",model.contact_person];
        cell.cell_contactWay.text = [NSString stringWithFormat:@"联系方式:%@",model.contact_way];
         cell.cell_contactAddress.text = [NSString stringWithFormat:@"联系地址:%@%@",model.user_address,model.address_details];
        cell.cell_contactContent.text = [NSString stringWithFormat:@"滤芯更换:"];
    }
    
    return cell  ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 140.f ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (_datas.count > indexPath.row) {

        JXAfterListModel * model = _datas[indexPath.row];

        [self performSegueWithIdentifier:@"JXNewAfterSalesViewController" sender:model];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"JXNewAfterSalesViewController"]) {

        JXNewAfterSalesViewController * vc = segue.destinationViewController;

        vc.model = sender ;

        vc.afterSalesType = vc.model.fas_type;

    }
}


-(JXPartnerBusiness *)business{
    
    if (_business==nil) {
        
        _business = [[JXPartnerBusiness alloc] init];
        
    }
    return _business;
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
