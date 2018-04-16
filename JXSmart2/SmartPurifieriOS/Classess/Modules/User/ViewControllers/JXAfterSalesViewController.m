//
//  JXAfterSalesViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/3.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXAfterSalesViewController.h"
#import "SPUserModulesBusiness.h"
#import "JXAfterListTableViewCell.h"
#import "JXAfterListModel.h"
#import "JXNewAfterSalesViewController.h"

@interface JXAfterSalesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray * datas ;

@property (nonatomic,strong) SPUserModulesBusiness * business ;

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
        
        [weakself requestAfteSalesList:1];
    }];
    
    [self.myTableView addJX_NormalFooterRefreshBlock:^{
        
        [weakself requestAfteSalesList:_currentPage+1];
        
    }];
    
    [self  compatibleAvailable_ios11:_myTableView];
    
    self.myTableView.tableFooterView = [UIView new];
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    [self requestAfteSalesList:1];

}


-(void)requestAfteSalesList:(NSInteger)page{

     _currentPage = page ;

    __weak typeof(self) weakself = self ;
    
    [self.business fetch_AfterSalesList:@{@"fas_state":@(_after_State),@"page":@(page)} success:^(id result) {

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

         [SPToastHUD makeToast:error makeView:weakself.view];
        
    }];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JXAfterListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];
    
    if (_datas.count > indexPath.row) {

        JXAfterListModel * model = _datas[indexPath.row];

        cell.cell_time.text = model.fas_addtime;

        cell.cell_content.text = model.specific_reason ;

        cell.cell_type.text = model.fas_type == 1 ? @"滤芯更换": model.fas_type == 2?@"设备报修":@"其他";

        cell.cell_state.text = model.fas_state == 200 ? @"已完成":@"等待售后处理";

    }
    
    
    return cell  ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90.f ;
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


-(SPUserModulesBusiness *)business{
    
    if (_business==nil) {
        
        _business = [[SPUserModulesBusiness alloc] init];
        
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
