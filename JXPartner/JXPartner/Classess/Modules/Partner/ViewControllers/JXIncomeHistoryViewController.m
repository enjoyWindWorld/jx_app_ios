//
//  JXIncomeHistoryViewController.m
//  JXPartner
//
//  Created by windpc on 2017/8/17.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXIncomeHistoryViewController.h"
#import "JXPartnerBusiness.h"
#import "JXIncomeHistoryModel.h"
#import "JXIncomeHistoryMoneyTableViewCell.h"

@interface JXIncomeHistoryViewController ()

@property (nonatomic,strong) JXPartnerBusiness * business ;

@property (nonatomic,strong) NSMutableArray * historyArr ;  //分组欠的

@property (nonatomic,assign) NSInteger readPage ;

@end

@implementation JXIncomeHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提现记录";
    
    _historyArr = [NSMutableArray arrayWithCapacity:0];

    [self.tableView addJXEmptyView];
    
    _readPage = 1;

    self.tableView.tableFooterView = [UIView new];
        
    [self addMJRefreshView];
    
    [self requestFetchTiXianHistory:_readPage];
    // Do any additional setup after loading the view.
}


-(void)addMJRefreshView{
    
    __weak typeof(self) weakself = self ;
    
    [self.tableView addJX_NormalHeaderRefreshBlock:^{
        
        [weakself requestFetchTiXianHistory:1];
    }];
    
    [self.tableView addJX_NormalFooterRefreshBlock:^{
        
        [weakself requestFetchTiXianHistory:_readPage+1];
    }];
    
}

-(void)requestFetchTiXianHistory:(NSInteger)page{
    
    _readPage = page ;
    
    __weak typeof(self) weakself = self ;
    
    
    [self.business fetchTiXianHistory:@{@"page":[NSNumber numberWithInteger:page]} success:^(id result) {
        
        NSArray * resultArr = result ;
        
        [weakself.tableView JXendRefreshing];
        
        if (page==1) {
            
            [weakself.historyArr removeAllObjects];
        }
        
        [weakself.historyArr addObjectsFromArray:resultArr];
        
        if(resultArr.count==0){
            
            [weakself.tableView JXfooterEndNoMoreData];
            
        }
        
        [weakself.tableView reloadData];
        
    } failer:^(NSString *error) {
        
        [weakself.tableView JXendRefreshing];
        
        [weakself makeToast:error];
        
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _historyArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

     JXIncomeHistoryModel * inHistory = _historyArr[section];
    

    return inHistory.viewItemArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    JXIncomeHistoryModel * inHistory = _historyArr[indexPath.section];
    
    if (indexPath.row==0) {
        
        JXIncomeHistoryMoneyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];
        
        cell.incomeState.text = [JXPartnerModulesMacro  fetchWithDrawal_State:inHistory.withdrawal_state];
        
        cell.incomeTime.text = inHistory.add_time;
        
        cell.incomeMoney.text = [NSString stringWithFormat:@"￥%.2f元",inHistory.withdrawal_amount];
        
        return cell ;
    }
    
    
    JXIncomeHistoryMoneyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL1" forIndexPath:indexPath];
    
    [self  configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(JXIncomeHistoryMoneyTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    JXIncomeHistoryModel * inHistory = _historyArr[indexPath.section];
    
    NSDictionary *dic = inHistory.viewItemArr[indexPath.row];
    
    cell.leftLabel.text = dic[HIS_LEFT_KEY];
    
    cell.rightLabel.text = dic[HIS_RIGHT_KEY];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
        
        return 140.f;
    }
    
    CGFloat cellHeght  = [tableView fd_heightForCellWithIdentifier:@"CELL1" configuration:^(JXIncomeHistoryMoneyTableViewCell* cell) {
        
        [self configureCell:cell atIndexPath:indexPath];
    }];
    
    return  cellHeght < 41? 30:cellHeght;

}


-(JXPartnerBusiness *)business{
    
    if (_business == nil) {
        
        _business  =[[JXPartnerBusiness alloc] init];
        
    }
    return  _business;
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
