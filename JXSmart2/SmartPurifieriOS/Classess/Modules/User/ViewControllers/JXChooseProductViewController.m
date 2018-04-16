//
//  JXChooseProductViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/6.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXChooseProductViewController.h"
#import "SPUserModulesBusiness.h"
#import "JXChooseProductTableViewCell.h"
#import "JXAfterProductModel.h"

@interface JXChooseProductViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) SPUserModulesBusiness * business ;

@property (nonatomic,assign) NSInteger  currentPage ;

@property (nonatomic,strong) NSMutableArray * datas ;

@end

@implementation JXChooseProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentPage = 1 ;
    
    self.title = @"选择设备";
    
    _datas = [NSMutableArray arrayWithCapacity:0];
    
    [self request_fetchProductList:1];
    
    [self.myTableView addJXEmptyView];
    
    __weak typeof(self) weakself = self ;
    
    [self.myTableView addJX_NormalHeaderRefreshBlock:^{
        
        [weakself request_fetchProductList:1];
    }];
    
    [self.myTableView addJX_NormalFooterRefreshBlock:^{
        
        [weakself request_fetchProductList:_currentPage+1];
        
    }];
    
    [self  compatibleAvailable_ios11:_myTableView];
    
    self.myTableView.tableFooterView = [UIView new];
    // Do any additional setup after loading the view.
}


/**
 获取自己的产品列表

 @param page 页码
 */
-(void)request_fetchProductList:(NSInteger)page{
    
    _currentPage = page ;
    
    __weak typeof(self) weakself = self ;
    
    [self.business fetch_productList:@{@"page":@(_currentPage)} success:^(id result) {
        
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
    
    JXChooseProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell ;
}

- (void)configureCell:(JXChooseProductTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    if (_datas.count > indexPath.row) {
        
        JXAfterProductModel * model = _datas [indexPath.row] ;
        
        cell.pro_name.text = model.pro_alias.length > 0 ? model.pro_alias : model.name ;
        
        cell.pro_color.text = model.color ;
        
        [SPSDWebImage SPImageView:cell.pro_ico imageWithURL:model.url placeholderImage:[UIImage imageNamed:SPPRODUCTICOPLACEHOLDERImage]];
        
        cell.pro_order.text = [NSString stringWithFormat:@"关联订单号:%@",model.ord_no];
        
        cell.pro_idcard.text = [NSString stringWithFormat:@"机器码:%@",model.pro_no];
        
        cell.pro_idcard.lineBreakMode = NSLineBreakByCharWrapping;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   CGFloat height  = [tableView fd_heightForCellWithIdentifier:@"CELL0" configuration:^(id cell) {
       
        [self configureCell:cell atIndexPath:indexPath];
    }];
    
    return height ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_datas.count > indexPath.row) {
        
        JXAfterProductModel * model = _datas [indexPath.row] ;
    
        if (_touchBlock) {
            
            _touchBlock(model);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
