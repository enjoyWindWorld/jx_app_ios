//
//  MyOrderViewController.m
//  SmartPurifieriOS
//
//  Created by Mray-mac on 2016/11/21.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "MyOrderViewController.h"
#import "JXPartnerOrderListTableViewCell.h"
#import "OrderDeitalViewController.h"
#import "OrderLitModel.h"
#import "SPUserModel.h"
#import "JXPartnerBusiness.h"
#import "JXSubPartnerModel.h"

@interface MyOrderViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) JXPartnerBusiness * business;

@property (nonatomic,strong) UITableView *tableV; ;

@property (nonatomic,strong) NSMutableArray * orderListArr ;  //分组欠的

@property (nonatomic,assign) NSInteger readPage ;

@end

@implementation MyOrderViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _orderListArr = [NSMutableArray arrayWithCapacity:0];
   
    [self initWithUI];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestMyOrderList:1];
    
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
}



-(void)initWithUI{
    
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-44) style:UITableViewStylePlain];
   
    _tableV.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    _tableV.delegate = self;
    
    _tableV.dataSource = self;
 
    _tableV.separatorStyle = YES;
  
    [self.view addSubview:_tableV];

    [_tableV setTableFooterView:[UIView new]];
    
    
    [_tableV registerNib:[UINib nibWithNibName:@"JXPartnerOrderListTableViewCell" bundle:nil] forCellReuseIdentifier:@"JXPartnerOrderListTableViewCell"];
    
    __weak __typeof (self)weakself = self;
    
    [self.tableV addJX_NormalHeaderRefreshBlock:^{
        
        [weakself requestMyOrderList:1];
    }];
    
    [self.tableV addJX_NormalFooterRefreshBlock:^{
        
        [weakself requestMyOrderList:_readPage+1];
    }];
    
    [_tableV addJXEmptyView];
}


#pragma mark- 网络代理  获取我的订单列表
-(void)requestMyOrderList:(NSInteger)currentpage{
    
    NSLog(@"OC FETCH");
    
    _readPage  = currentpage;
    
    __weak typeof(self) weakself  = self;
    if (!_model) {
    
        
        [self.business fetchPartnerOrderList:@{@"page":[NSString stringWithFormat:@"%ld",currentpage],@"state":_state} success:^(id result) {
            
            __strong __typeof(weakself)strongSelf = weakself;
            
            [strongSelf.tableV JXendRefreshing ];
            
            NSArray * resultArr = result ;
            
            if (currentpage==1) {
                
                [strongSelf.orderListArr removeAllObjects];
            }
            
            if (resultArr.count==0) {
                
                [strongSelf.tableV JXfooterEndNoMoreData];
            }
            
            [strongSelf.orderListArr addObjectsFromArray:resultArr];
            
            
            [strongSelf.tableV reloadData];
            
        } failer:^(id error) {
            
            [weakself.tableV JXendRefreshing ];
            
            [weakself makeToast:error];
        }];
        
        return ;
    }
    

    [self.business fetchPartnerSubOrderlist:@{@"page":[NSString stringWithFormat:@"%ld",currentpage],@"state":_state,@"username":_model.par_id} success:^(id result) {
        
        __strong __typeof(weakself)strongSelf = weakself;
        
        [strongSelf.tableV JXendRefreshing ];
        
        NSArray * resultArr = result ;
        
        if (currentpage==1) {
            
            [strongSelf.orderListArr removeAllObjects];
        }
        
        if (resultArr.count==0) {
            
            [strongSelf.tableV JXfooterEndNoMoreData];
        }
        
        [strongSelf.orderListArr addObjectsFromArray:resultArr];
        
        
        [strongSelf.tableV reloadData];
        
    } failer:^(id error) {
        
        [weakself.tableV JXendRefreshing ];
        
        [weakself makeToast:error];
    }];


}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.orderListArr.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //cell创建视图
    JXPartnerOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JXPartnerOrderListTableViewCell"];

    if (self.orderListArr.count>indexPath.row) {
        
        OrderLitModel *m = self.orderListArr[indexPath.row];
        
        cell.ordernameLabel.text = m.name;
        
        cell.ordertimeLabel.text = m.addtime;
        
        cell.orderpriceLabel.text = [NSString stringWithFormat:@"%@元",m.price];
        
        cell.orderstateLabel.text = [m fetchOrderStateDescription];
        
        cell.ordersnLabel.text = [NSString stringWithFormat:@"订单号:%@",m.ordno];
        
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return 95.f;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    OrderDeitalViewController *vc = [[OrderDeitalViewController alloc]init];
    
    if (self.orderListArr.count>indexPath.row) {
        
        OrderLitModel *m = self.orderListArr[indexPath.row];
        
        if (!m) return ;
        
        vc.ordno = m.ordno;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - gettet setter

-(JXPartnerBusiness *)business{
    
    if (_business == nil) {
        
        _business  =[[JXPartnerBusiness alloc] init];
        
    }
    return  _business;
}




@end
