//
//  JXChooseFitlerViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/7.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXChooseFitlerViewController.h"
#import "SPUserModulesBusiness.h"
#import "JXChooseProductTableViewCell.h"
#import "JXFitlerModel.h"
@interface JXChooseFitlerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) SPUserModulesBusiness * business ;

@property (nonatomic,strong) NSMutableArray * datas ;

@end

@implementation JXChooseFitlerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.title = @"选择滤芯";
    
    _datas = [NSMutableArray arrayWithCapacity:0];
    
    [self request_fetchFitlerList];
    
    [self.myTableView addJXEmptyView];

    [self  compatibleAvailable_ios11:_myTableView];
    
    self.myTableView.tableFooterView = [UIView new];
    
    [self request_fetchFitlerList];

    self.myTableView.allowsMultipleSelection = YES;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(local_insertFirtler)];

    self.myTableView.editing = YES ;
}

#pragma mark - 确认选择的滤芯
-(void)local_insertFirtler{

    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];

    NSArray * selectArr = self.myTableView.indexPathsForSelectedRows ;

    if (selectArr.count == 0 ) {

        [SPToastHUD makeToast:@"未选中要更换的滤芯" duration:3 position:nil makeView:self.view];

        return ;
    }

    for (NSIndexPath* indexArr in  self.myTableView.indexPathsForSelectedRows) {

        JXFitlerModel * model = _datas[indexArr.row] ;

        [arr addObject:model];

        NSLog(@"choose  %@",model.name);
    }
    if (_touchBlock) {

        _touchBlock(arr);
    }
    [self.navigationController popViewControllerAnimated:YES];

}

/**
 获取滤芯寿命
 */
-(void)request_fetchFitlerList{

    __weak typeof(self) weakself = self ;
    
    [self.business fetch_trafficList:@{@"pro_no":_prono} success:^(id result) {
        
        [weakself.myTableView JXendRefreshing];
        
        NSArray * resultArr = result ;

        if (resultArr.count==0) {
            
            [weakself.myTableView JXfooterEndNoMoreData];
        }
        
        weakself.datas = resultArr ;
        
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
    
    JXChooseProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];
    
    JXFitlerModel * model = _datas[indexPath.row] ;
  
    cell.pro_name.text = model.name ;

    cell.pro_order.text = [NSString stringWithFormat:@"%.2f%%",model.proportion];
 
    
    return cell ;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.f ;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}



#pragma mark - 业务请求
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
