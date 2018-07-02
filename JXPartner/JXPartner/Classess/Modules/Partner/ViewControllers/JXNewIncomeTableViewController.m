//
//  JXNewIncomeTableViewController.m
//  JXPartner
//
//  Created by windpc on 2017/8/24.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXNewIncomeTableViewController.h"
#import "JXPartnerBusiness.h"
#import "JXCurrentIncomeDetailModel.h"
#import "JXNewIncomeHeaderView.h"
#import "JXincomeDetailTableViewCell.h"
#import "JXPartnerViewElectricityEntrance.h"
#import "ShieldEmoji.h"


#define SECTIONTITLE @"sectionTitle"
#define SECTIONDATA @"sectionData"

#define SECTIONDATA_LEFT @"SECTIONDATA_LEFT"
#define SECTIONDATA_RIGHT @"SECTIONDATA_RIGHT"

@interface JXNewIncomeTableViewController ()

@property (nonatomic,strong) JXPartnerBusiness * business ;

@property (nonatomic,strong) JXCurrentIncomeDetailModel * model ;

@property (nonatomic,strong) NSMutableArray * itemArr ;

@property (nonatomic,strong)   JXNewIncomeHeaderView * header ;

@end

@implementation JXNewIncomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    if (_subModel) {
        
        self.title = _subModel.name;
        
        [self requestSubFetchTiXianDetail];
        
    }else{
    
        if (_walletOrdersn) {
            
            self.title = @"提现金额";
        
            [self  requestFetchTiXianDetail:_walletOrdersn];
            
            _header = [[JXNewIncomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150.f)];
            
            _header.costMoneyLabel.text = _defaultMoney;
            
            self.tableView.tableHeaderView = _header ;
            
        }
    }

    
}

#pragma mark- 构建页面数据
-(void)loadViewDataSource{

    if (!_model) {
        
        return;
    }
    
    if (_model.state == Withdrawal_State_Temporary) {
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提现" style:UIBarButtonItemStylePlain target:self action:@selector(requestNewIncome)];
        
    }else if (_model.state == Withdrawal_State_Initiate && _isAdult){
    
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"审核" style:UIBarButtonItemStylePlain target:self action:@selector(requestAdultIncome)];
    }
    
    
    _header.costMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f元",_model.withdrawal_total_amount];
    
    _itemArr = [NSMutableArray arrayWithCapacity:0];
    
    NSArray * item = @[@{SECTIONDATA_LEFT:@"提现单号",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@",_model.withdrawal_order_no]},
                       @{SECTIONDATA_LEFT:@"提现人编号",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@",_model.user_number]},
                       @{SECTIONDATA_LEFT:@"提现日期",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@",_model.sales_time]},
                         @{SECTIONDATA_LEFT:@"壁挂式净水机",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@台",_model.wall]},
                       @{SECTIONDATA_LEFT:@"台式净水机",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@台",_model.desktop]},
                       @{SECTIONDATA_LEFT:@"立式净水机",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@台",_model.vertical]},
                     @{SECTIONDATA_LEFT:@"购买型合计(去押金)",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%.2f元",_model.buy_combined]}
                       ];
    
    NSDictionary * dic = @{SECTIONTITLE:@"购买型",SECTIONDATA:item};
    
    NSArray * item1 = @[@{SECTIONDATA_LEFT:@"壁挂式净水机续费",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@单",_model.wall_renew]},
                       @{SECTIONDATA_LEFT:@"台式净水机续费",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@单",_model.desktop_renew]},
                       @{SECTIONDATA_LEFT:@"立式净水机续费",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@单",_model.vertical_renew]},
                         @{SECTIONDATA_LEFT:@"续费型合计(去押金)",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%.2f元",_model.renewal_combined]}
                       ];
    
    NSDictionary * dic1 = @{SECTIONTITLE:@"续费型",SECTIONDATA:item1};
    
    NSArray *  item2 = @[@{SECTIONDATA_LEFT:@"是否按照合同",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@",_model.ispact == YES?@"是":@"否"]},
                        @{SECTIONDATA_LEFT:@"返利比例",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%.2f",_model.wdl_fee]},
                         // @{SECTIONDATA_LEFT:@"市场推广比例",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%.2f",_model.rwl_install]},
                        @{SECTIONDATA_LEFT:@"服务费返利",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%.2f元",_model.service_fee]},
                         @{SECTIONDATA_LEFT:@"服务费续费返利",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%.2f元",_model.renewal]},
                         //@{SECTIONDATA_LEFT:@"市场推广补贴",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%.2f元",_model.installation]},
                         @{SECTIONDATA_LEFT:@"下级返利",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"合计:%.2f元",_model.lower_rebate]}];
    
    NSDictionary * dic2 = @{SECTIONTITLE:@"提现项",SECTIONDATA:item2};
    
    [_itemArr addObject:dic];
    [_itemArr addObject:dic1];
    [_itemArr addObject:dic2];
    
}
#pragma mark - 构建页面数据
-(void)loadViewSubDataSource{
    
    if (!_model) {
        
        return;
    }
    
    _header.costMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f元",_model.withdrawal_total_amount];
    
    _itemArr = [NSMutableArray arrayWithCapacity:0];
    
    NSArray * item = @[@{SECTIONDATA_LEFT:@"壁挂式净水机",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@台",_model.wall]},
                       @{SECTIONDATA_LEFT:@"台式净水机",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@台",_model.desktop]},
                       @{SECTIONDATA_LEFT:@"立式净水机",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@台",_model.vertical]}
                       ];
    
    NSDictionary * dic = @{SECTIONTITLE:@"购买型",SECTIONDATA:item};
    
    NSArray * item1 = @[@{SECTIONDATA_LEFT:@"壁挂式净水机续费",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@单",_model.wall_renew]},
                        @{SECTIONDATA_LEFT:@"台式净水机续费",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@单",_model.desktop_renew]},
                        @{SECTIONDATA_LEFT:@"立式净水机续费",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%@单",_model.vertical_renew]}
                        ];
    
    NSDictionary * dic1 = @{SECTIONTITLE:@"续费型",SECTIONDATA:item1};
    
    NSArray *  item2 = @[
                         @{SECTIONDATA_LEFT:@"去押金总金额",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%.2f元",_model.total_money]},
                         @{SECTIONDATA_LEFT:@"返利比例",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%.2f",_model.by_tkr_rebates]},
                         @{SECTIONDATA_LEFT:@"服务费返利",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%.2f元",_model.service_fee]},
                         @{SECTIONDATA_LEFT:@"服务费续费返利",SECTIONDATA_RIGHT:[NSString stringWithFormat:@"%.2f元",_model.renewal]},
                         ];
    
    NSDictionary * dic2 = @{SECTIONTITLE:@"提现项",SECTIONDATA:item2};
    
    [_itemArr addObject:dic];
    [_itemArr addObject:dic1];
    [_itemArr addObject:dic2];
    
}

#pragma 获取体现单详情
-(void)requestFetchTiXianDetail:(NSString*)walletOrder{
    
    __weak  typeof(self)  weakself  = self ;

    [self showDefaultWithStatus:@"请稍后..."];
    
    [self.business fetchTiXianSaleItem:@{@"withdrawal_order_no":walletOrder} success:^(id result) {
        
        [UIViewController dismiss];
        
        weakself.model = result ;
        
        [weakself loadViewDataSource];
        
        [weakself.tableView reloadData];
    } failer:^(id error) {
        
        [UIViewController dismiss];
        
        [weakself makeToast:error];
        
    }];
    
}

#pragma mark - 获取下级体现单
-(void)requestSubFetchTiXianDetail{
    
    __weak  typeof(self)  weakself  = self ;
    
    [self showWithStatus:@"请稍后..."];
    
    [self.business fetchSubTiXianSale:@{@"withdrawal_order_no":_walletOrdersn,@"id":_subModel.dataid} success:^(id result) {
        
        [UIViewController dismiss];
        
        weakself.model = result ;
        
        [weakself loadViewSubDataSource];
        
        [weakself.tableView reloadData];
    } failer:^(id error) {
        
        [UIViewController dismiss];
        
        [weakself makeToast:error];
        
    }];
    
}

#pragma 提现点击
-(void)requestNewIncome{
    
    if (!_walletOrdersn || !_model)
        
        return ;
    
    
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示"message:@"确认提现"preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        [self requestInitiateWithdrawal];
        
    }];
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - 审核点击
-(void)requestAdultIncome{

    if (!_walletOrdersn || !_model)
        
        return ;
    

    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示"message:[NSString stringWithFormat:@"提现单%@审核操作",_walletOrdersn] preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"通过"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
       [self requestAdultSubWithdrawal:YES reason:nil];
        
    }];
    
    UIAlertAction *okAction1 = [UIAlertAction actionWithTitle:@"拒绝"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField * textf= alertController.textFields.firstObject;
       
        if (textf.text.length == 0 ) {
            
            [self makeToast:@"请输入拒绝原因"];
        }else if ([ShieldEmoji isContainsNewEmoji:textf.text]) {
            
            [self makeToast:@"不能包含表情"];
        }else{
        
            [self requestAdultSubWithdrawal:NO reason:textf.text];
            
        }
        
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        
        textField.placeholder = @"请输入拒绝原因";
        
    }];
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:okAction];
    
     [alertController addAction:okAction1];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark- 开始请求提现
-(void)requestInitiateWithdrawal{

    __weak  typeof(self)  weakself  = self ;
    
    [self showWithStatus:@"请稍后..."];
    
    [self.business fetchTiXianRequestAdd:@{@"withdrawal_order_no":_model.withdrawal_order_no} success:^(id result) {
        
        [weakself showSuccessWithStatus:@"提现发起成功，待审核"];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } failer:^(id error) {
        
        [UIViewController dismiss];
        
        [weakself makeToast:error];
        
    }];
}

#pragma mark - 开始审核
-(void)requestAdultSubWithdrawal:(BOOL)isAgree reason:(NSString*)reason{
    
    NSInteger state = isAgree == YES ? 3 : 1 ;
    
    __weak  typeof(self)  weakself  = self ;
    
    [self showWithStatus:@"请稍后..."];
    
    [self.business updateSubTiXianState:@{@"withdrawal_order":_walletOrdersn,@"state":@(state),@"reason":reason} success:^(id result) {
        
        [weakself  showSuccessWithStatus:@"处理成功"];
        
        [weakself.navigationController popViewControllerAnimated:YES];
        
    } failer:^(id error) {
        
         [UIViewController dismiss];
        
        [weakself makeToast:error];
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _itemArr.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSDictionary * dic = _itemArr[section];
    
    NSArray * arr = dic[SECTIONDATA];
    
    if (section == 2) {
        
        return arr.count + _model.direct_subordinates.count;
    }
    
    return arr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dic = _itemArr[indexPath.section];
    
    NSArray * sectionArr = dic[SECTIONDATA];
    
    if (indexPath.section == 2 && indexPath.row >= sectionArr.count) {
     
        JXincomeDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL1" forIndexPath:indexPath];
        
        JXSubCurrentModel * model = _model.direct_subordinates[indexPath.row-sectionArr.count];
        
        cell.oneLabel.text = model.name;
        
        cell.twoLabel.text = [NSString stringWithFormat:@"编号:%@",model.number];
        
        cell.threeLaebl.text = [NSString stringWithFormat:@"返利比例:%.2f",model.rebates];
        
        cell.fourLabel.text = [NSString stringWithFormat:@"合计:%.2f",model.money];
        
        return cell ;
    }
    
    NSDictionary * sectionData =  sectionArr[indexPath.row];

    JXincomeDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];
    
    cell.typeLabel.text = sectionData[SECTIONDATA_LEFT];
    
    cell.priceLabel.text = sectionData[SECTIONDATA_RIGHT];
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return .1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 30.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dic = _itemArr[indexPath.section];
    
    NSArray * sectionArr = dic[SECTIONDATA];
    
    if (indexPath.section == 2 && indexPath.row >= sectionArr.count) {
        
        return 65.f;
    }

    return 44.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary * dic = _itemArr[indexPath.section];
    
    NSArray * sectionArr = dic[SECTIONDATA];
    
    if (indexPath.section == 2 && indexPath.row >= sectionArr.count) {
    
        JXSubCurrentModel * model = _model.direct_subordinates[indexPath.row-sectionArr.count];
        
        UIViewController * vc  = [JXPartnerViewElectricityEntrance  fetchNewIncomeViewController:model ordno:_model.withdrawal_order_no];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}


-(JXPartnerBusiness *)business{
    
    if (!_business) {
        
        _business = [[JXPartnerBusiness alloc] init];
    }
    
    return _business ;
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
